resource "aws_dynamodb_table" "create_dynamodb_table" {
  name = "${var.name_prefix}-dynamo"

  provider = aws.default

  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}