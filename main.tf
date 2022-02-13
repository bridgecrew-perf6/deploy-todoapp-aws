terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  alias = "us-east-1"

  region = "us-east-1"

  shared_credentials_file = var.shared_credentials_file
}

provider "aws" {
  alias = "default"

  region = var.region

  shared_credentials_file = var.shared_credentials_file
}