provider "aws" {
  region = "us-west-2"
}

import {
  to = aws_vpc.my_first_vpc
  id = "vpc-0b37c8c1dd6d9c791"
}

import {
  to = aws_vpc.my_second_vpc
  id = "vpc-0f6dfe950c6d4273b"
}

resource "aws_vpc" "my_first_vpc" {}
resource "aws_vpc" "my_second_vpc" {}