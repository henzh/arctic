output "database_name" {
    value = "aws_db_instance.default.name"
}

output "database_endpoint" {
    value = "aws_db_instance.default.endpoint"
}

output "database_address" {
    value = "aws_db_instance.default.address"
}

output "service" {
    value = "http://${local.ingress_hosts}"
}
