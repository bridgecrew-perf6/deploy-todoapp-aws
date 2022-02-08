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
  alias = "eu-south-1"

  region = "eu-south-1"

  shared_credentials_file = var.shared_credentials_file
}