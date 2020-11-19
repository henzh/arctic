resource "aws_iam_role" "cron_role" {
    name = "${var.application}-iam-role-${var.environment}"
    assume_role_policy = <<EOF 
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AllowCronAssumeRole",
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com" 
                }
            }
        ]
    }
    EOF
}

resource "aws_iam_policy" "vpc" {
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AllowCronVpc",
                "Effect": "Allow",
                "Action": [
                    "ec2:DescribeInstance",
                    "ec2:CreateNetworkInterfaceS",
                    "ec2:DescribeNetworkInterfaceS",
                    "ec2:AttachNetworkInterfaceS",
                    "ec2:DeleteNetworkInterfaceS",
                ],
                "Resource": "*"   
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "vpc_attach" {
    role = aws_iam_role.cron_role.name
    policy_arn = aws_iam_policy.vpc.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_attach" {
    role = aws_iam_role.cron_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
