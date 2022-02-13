output "s3_website_endpoint" {
  value = aws_s3_bucket.create_bucket_s3.website_endpoint
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.create_cloudfront_distribution.domain_name
}

output "apigateway_endpoint" {
  value = module.api_gateway.apigatewayv2_api_api_endpoint
}

output "dynamo_arn" {
  value = aws_dynamodb_table.create_dynamodb_table.arn
}

output "backend_lambda_arn" {
  value = module.create_backend_lambda.lambda_function_arn
}