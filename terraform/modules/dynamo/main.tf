resource "aws_dynamodb_table" "cron_db" {
    name = "${var.application}-crondb-${var.environment}"

    read_capacity = 1
    write_capacity = 1

    hash_key = "uuid"

    attribute {
        name = "uuid"
        type = "S"
    }

    tags = {

    }
}
