resource "aws_dynamodb_table" "dynamodbtable" {
    name           = "${var.project_name}-dynamodbtable"
    billing_mode   = var.billing_mode
    read_capacity  = var.read_capacity
    write_capacity = var.write_capacity
    hash_key       = var.hash_key


    attribute {
        name = "${var.hash_key}"
        type = var.type
    }

    tags = {
        Name        = "${var.project_name}-dynamodbtable"
    }

}