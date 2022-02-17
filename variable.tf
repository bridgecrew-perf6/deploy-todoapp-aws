variable "region" {
  default = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix which will be assigned at all names of the resources created"
  type = string
  default = "todoapp"
}

variable "shared_credentials_file" {
  type = string
  default = "~/.aws/credentials"
}

variable "website_path" {
  description = "Path where is located the build of the SPA app"
  type = string
  default = "./src/react-simple-todo-app/dist"
}

variable "backend_lambda_path" {
  description = "Path where is located the lambda function of backend app"
  type = string
  default = "./src/todo-app-serverless/src"
}

variable "openid_client_lambda_path" {
  description = "Path where is located the lambda function of openidclient"
  type = string
  default = "./src/open-id-client-serverless/src"
}

variable "domain_name" {
  description = "Domain name to associate to cloudfront"
  type = string
}

variable "domain_certificate_arn" {
  description = "Arn of the ssl certificate stored in aws certificate manager"
  type = string
}

variable "openid_config" {
  description = "Parameters for openid client which will be proxied to lambda@edge function"
  type = object({
    CLIENT_ID : string
    CLIENT_SECRET : string
    AUDIENCES : list(string)
    IDP_METADATA_URL : string
  })
}