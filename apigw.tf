resource "aws_apigatewayv2_authorizer" "openid_authorizer" {
  api_id           = module.api_gateway.apigatewayv2_api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "IDP"

  jwt_configuration {
    audience = var.openid_config.AUDIENCES
    issuer   = var.openid_config.IDP_METADATA_URL
  }

  provider = aws.default

}

module "api_gateway" {
  source                 = "registry.terraform.io/terraform-aws-modules/apigateway-v2/aws"
  version                = "1.5.1"
  name                   = "todoapp-apigw"
  create_api_domain_name = false

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  integrations = {
    "ANY /api/v1/{proxy+}" = {
      lambda_arn             = "${module.create_backend_lambda.lambda_function_arn}:${module.create_backend_lambda.lambda_function_version}"
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      authorization_type     = "JWT"
      authorizer_id          = aws_apigatewayv2_authorizer.openid_authorizer.id
    }
  }

  providers = {
    aws : aws.default
  }
}