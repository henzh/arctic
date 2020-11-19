variable "application" {

}

variable "environment" {

}

variable "jvm_options" {
    // default = "-XX:..."
}

variable "region" {

}

variable "image" {
    // docker image repository
}

variable "tags" {
    
}

variable "certificate_arn" {

}

variable "alb_sg" {

}

variable "resources_limits_cpu" {

}

variable "resources_limits_memory" {

}

variable "resources_requests_cpu" {

}

variable "resources_requests_memory" {

}

variable "alb_ingress_cidr" {

}

variable "vpc_id" {

}

// Note: K8s Cluster

variable "helm_home" {

}

variable "tiller_namespace" {

}

variable "helm_charts_repository_url" {

}

variable "helm_service_account" {

}

// Note: RDS

variable "multi_az" {

}

variable "database_name" {

}

variable "database_username" {

}

variable "database_password" {

}

variable "storage_type" {

}

variable "engine" {

}

variable "engine_version" {

}

variable "instance_class" {

}

variable "parameter_group" {

}

variable "allocated_storage" {

}

variable "backup_retention_period" {

}

variable "backup_window" {

}

variable "monitoring_interval" {

}

variable "snapshot_identifier" {

}

variable "storage_encrypted" {
    
}

variable "subnet_ids" {
    type = "list"
}

variable "sg_ingress_cidr_blocks" {
    type = "list"
}
