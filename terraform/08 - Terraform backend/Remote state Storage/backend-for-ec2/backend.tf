terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "bootcamp32-50-ken"
    key    = "dev/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-west-2"

  }
}

# Provider Block
provider "aws" {
  region = "us-west-2"
}
