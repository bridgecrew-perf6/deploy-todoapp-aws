module "create_openid_client" {
  source        = "registry.terraform.io/terraform-aws-modules/lambda/aws"
  version       = "2.34.0"
  function_name = "${var.name_prefix}-open-id-client"
  handler       = "app.lambdaHandler"
  runtime       = "nodejs14.x"
  source_path   = var.openid_client_lambda_path
  lambda_role   = module.create_role_lambda.iam_role_arn
  create_role   = false
  publish       = true

  providers = {
    aws : aws.us-east-1
  }
}


module "create_backend_lambda" {
  source        = "registry.terraform.io/terraform-aws-modules/lambda/aws"
  version       = "2.34.0"
  function_name = "${var.name_prefix}-lambda"
  handler       = "app.lambdaHandler"
  runtime       = "nodejs14.x"
  source_path   = var.backend_lambda_path
  lambda_role   = module.create_role_lambda.iam_role_arn
  create_role   = false
  publish       = true

  environment_variables = {
    TASK_TABLE : aws_dynamodb_table.create_dynamodb_table.id
  }
  providers = {
    aws : aws.default
  }
}