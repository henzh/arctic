variable "application" {
    default = ""
}

variable "environment" {

}

variable "schedule" {
    default = rate(1 day)
}

variable "lambda_arn" {

}
