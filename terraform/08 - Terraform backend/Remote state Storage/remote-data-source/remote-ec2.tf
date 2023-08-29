terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Provider Block
provider "aws" {
  region  = "us-west-1"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "bootcamp32-50-ken"
    key    = "vpc/terraform.tfstate"
    region = "us-west-2"
  }
}

/*
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
      path    = "../../backend/terraform.tfstate"
  }
}
*/
resource "aws_instance" "dev" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.network.outputs.private_subnets[1]

  tags = {
    "Name" = "My_ec2"
  }
}

moved {
  from = aws_instance.my-ec2
  to   = aws_instance.dev
}

