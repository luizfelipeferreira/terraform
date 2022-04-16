provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.avail_zone]
  public_subnets  = [var.vpc_cidr_block]
  public_subnet_tags = { Name = "${var.env_prefix}-subnet-1" }

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "myapp-webserver" {
  source = "./modules/webserver"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  my_ip = var.my_ip
  public_key_location = var.public_key_location
  env_prefix = var.env_prefix
  instance_type = var.instance_type
  avail_zone = var.avail_zone
}