resource "aws_security_group" "alb" {
    name = "${var.application}-alb-sg-${var.environment}"
    vpc_id = var.vpc_id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.sg_ingress_cidr_blocks
    }
}

resource "aws_security_group" "db" {
    name = "${var.application}-db-sg-${var.environment}"
    vpc_id = var.vpc_id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "TCP"
        cidr = var.sg_ingress_cidr_blocks
    }

    egress {
        from_port = 0
        to_port = 0
        protocl = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "helm_release" "service" {
    name = "${var.application}-${var.environment}"
    repository = var.helm_charts_repository_url
    chart = var.application
    namespace = "${var.application}-${var.environment}"
    values = [data.template_file.values_yaml.rendered]
}

resource "null_resource" "default-helmconfig" {
    triggers = {
        always_run = timestamp()
    }

    provisioner "local-exec {
        command = "helm init --service-account ${var.helm_service_account_name} --client-only --tiller-namespace ${var.tiller_namespace}"
    }

    provisioner "local-exec" {
        command = "helm repo add cppib ${var.cppib_helm_charts_repo_url}"
    }
}

data "aws_vpc" "vpc" {
    id = var.vpc_id
}

data "aws_acm_certificate" "certificate" {
    domain = "*.${var.aws_acm_domain}"
    types = ["AMAZON_ISSUED"]
    most_recent = true
}

data "template_file" "values_yaml" {
    template = file("${path.module}/values.yaml.tpl")
    vars = {
        application = var.application
        environment = var.environment
        jvm_options = var.jvm_options
        region = var.region
        certificate_arn = var.certificate_arn
        image = var.image
        tags = var.tags
        resources_limits_cpu = var.resources_limits_cpu
        resources_limits_memory = var.resources_limits_memory
        resources_requests_cpu = var.resources_requests_cpu
        resources_requests_memory = var.resources_requests_memory
    }
}

locals {
    ingress_hosts = "${var.application}-${var.environment}.${var.aws_acm_domain}"
}

resource "aws_db_instance" "db" {
    name = "${var.database_name}"
    username = "${var.database_username}"
    password = "${var.database_password}"
    
    instance_class = "${var.instance_class}"
    storage_type = "${var.storage_type}"
    allocated_storage = "${var.allocated_storage}"
    storage_encrypted = "${var.storage_encrypted}"
    engine = "${var.engine}"
    engine_version = "${var.engine_version}"
    
    backup_retention_period = "${var.backup_retention_period}"
    backup_window = "${var.backup_window}"
    monitoring_interval = "${var.monitoring_interval}"
    monitoring_role_arn = ${aws_iam_role.monitoring_role_arn}

    multi_az = "${var.multi_az}"
    publicly_accessible = false

    snapshot_identifer = "${var.snapshot_identifer}"
    final_snapshot_identifier = "snapshot-${uuid()}"
}
