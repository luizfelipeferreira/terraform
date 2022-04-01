provider "aws" {
  region = "us-east-1"
  access_key = "AKIATASTXG2YQGU6M7HY"
  secret_key = "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"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-development"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "subnet-development-1"
  }
}

data "aws_vpc" "existing_vpc" {
  id = aws_vpc.development-vpc.id
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "subnet-development-2"
  }
}

output "vpc-dev-id" {
  value = aws_vpc.development-vpc.id
}

output "subnet-1-dev-id" {
  value = aws_subnet.dev-subnet-1.id
}