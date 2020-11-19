resource "aws_lambda_function" "cron" {
    function_name = "${var.application}-cron-${var.environment}"
    handler = var.handler
    runtime = var.runtime

    s3_bucket = var.artifact
    s3_key = var.artifact_key

    role = aws_iam_role_cron_role.arn

    vpc_config {
        security_group_ids = ["aws_security_group.cron_sg"]
        subnet_ids = var.subnets
    }

    environment {
        variables = {

        }
    }

    timeout = var.timeout
    depends_on = ["aws_cloudwatch_log_group.cron_log_group"]
}

resource "aws_lambda_permission" "cloudwatch_event_rule" {
    action = "lambda:InvokeAction"
    function_name aws.aws_lambda_function.cron.function_name
    principal = "events.amazonaws.com"
    source_arn = var.cloudwatch_event_rule_arn
}

resource "aws_security_group" "cron_sg" {
    name = "${var.application}-cron-sg-${var.environment}"
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {

    }
}
