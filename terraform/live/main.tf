module "lambda" {
    source = "../../modules/lambda"

    application = var.application
    environment = var.environment
    artifact_key = var.artifact_key
    artifact = var.artifact
    vpc_id = var.vpc_id
    subnets = var.subnets
    region = var.region
}


module "cloudwatch" {
    source = "../../modules/cloudwatch"

    application = var.application
    environment = var.environment
    cron_arn = var.cron_arn
    schedule = var.schedule   
}


module "dynamo" {
    source = "../../modules/dynamo"

    application = var.application
    environment = var.environment
}