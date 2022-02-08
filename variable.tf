variable "region" {
  default = "us-east-1"
}

variable "shared_credentials_file" {
  type = string
}

variable "website_root" {
  type = string
}

variable "domain_name" {
  type = string
}
variable "domain_certificate_arn" {
  type = string
}

variable "openid" {
  type = object({
    CLIENT_ID: string
    CLIENT_SECRET: string
    AUDIENCES: list(string)
    IDP_METADATA_URL: string
  })
}