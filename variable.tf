variable "region" {
  default = "us-east-1"
}

variable "name_prefix" {
  type = string
}

variable "shared_credentials_file" {
  type = string
}

variable "website_path" {
  type = string
}

variable "backend_lambda_path" {
  type = string
}

variable "openid_client_lambda_path" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "domain_certificate_arn" {
  type = string
}

variable "openid_config" {
  type = object({
    CLIENT_ID : string
    CLIENT_SECRET : string
    AUDIENCES : list(string)
    IDP_METADATA_URL : string
  })
}