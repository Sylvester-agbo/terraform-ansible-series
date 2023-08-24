# Solution for  ec2 project
1) Create a new folder /directory called: ec2-02
2) Create an ec2 instance named "FirstEC2" in your default region.
3) Use the ami of an ubuntu instance.
4) The instance size needs to be t2.micro
=================================================================

# Terraform Settings Block
terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Resource Block

resource "aws_instance" "project2ec2" {
    ami = ""
    instance_type = "t2.micro"

    tags = {
        Name = "FirstEC2"
    }
}
