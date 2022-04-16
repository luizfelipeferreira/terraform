provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "${var.env_prefix}-vpc"
    environment: var.env_prefix
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.myapp-vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  env_prefix = var.env_prefix
  avail_zone = var.avail_zone
}

module "myapp-webserver" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp-vpc.id
  subnet_id = module.myapp-subnet.subnet.id
  my_ip = var.my_ip
  public_key_location = var.public_key_location
  env_prefix = var.env_prefix
  instance_type = var.instance_type
  avail_zone = var.avail_zone
}