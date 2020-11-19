resource "aws_cloudwatch_event_rule" "event_rule" {
    name = "${var.application}-event-${var.environment}"
    schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "cron-lambda" {
    arn = var.cron_lambda_arn
    rule = aws_cloudwatch_event_rule.event_rule.name
}
