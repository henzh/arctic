data "aws_secretsmanager_secret" "secret_manager" {

}

data "aws_iam_policy_document" "assume_role" {
    statement {
        actions = ["sts:AssumeRole"]
        effect = "Allow"
    }

    principals {
        type = "Service"
        identifiers = ["monitoring.rds.amazonaws.com"]
    }
}

data "aws_caller_identity" "current" {

}

resource "aws_iam_role" "service" {
    name = "${var.application}-service-${var.environment}"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:assumeRole"
            },
            {
                "Sid": "Allow",
                "Principal": {
                    "AWS": ${var.cluster_node_role_arn}
                }
            }
        ]

    }
    EOF
}

resource "aws_iam_policy" "service_policy" {
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    
                ]
            }
        ],
        "Resource": [
            
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment"



resource "aws_iam_role" "monitor" {
    name = "${var.application}-monitor-${var.environment}"
    path = "/"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "general_access" {
    policy_arn = aws_iam_policy.service_policy.arn
    role = aws_iam_role.service_role.name
}

resource "aws_iam_role_policy_attachment" "cloudwatch_access" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role = aws_iam_role.service_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.service_role.name
}

resource "aws_iam_role_policy_attachment" "monitoring_access" {
    role = aws_iam_role.service_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhanceMonitoringRole"
}
