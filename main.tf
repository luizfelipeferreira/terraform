provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  description = "Inform here your environment"
  default = "dev"
  type = string
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "vpc-development"
    Environment: var.environment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "subnet-development-1"
    Environment: var.environment
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
    Environment: var.environment
  }
}

output "vpc-dev-id" {
  value = aws_vpc.development-vpc.id
}

output "subnet-1-dev-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "environment" {
  value = var.environment
}