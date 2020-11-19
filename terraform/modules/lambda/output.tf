output "cron_arn" {
    value = aws_lambda_function.cron.arn
}

output "cron_role" {
    value = aws_iam_role.cron_role.arn
}
