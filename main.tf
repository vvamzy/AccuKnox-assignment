# main.tf

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

module "vpc_us_east_1" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  region   = "us-east-1"
}

module "vpc_us_east_2" {
  source   = "./modules/vpc"
  providers = {
    aws = aws.us-east-2
  }
  vpc_cidr = "10.1.0.0/16"
  region   = "us-east-2"
}

module "ec2_us_east_1" {
  source        = "./modules/ec2"
  vpc_id       = module.vpc_us_east_1.vpc_id
  subnet_id    = module.vpc_us_east_1.public_subnet_ids[0]
  region       = "us-east-1"
  instance_type = var.instance_type
}

module "ec2_us_east_2" {
  source        = "./modules/ec2"
  providers = {
    aws = aws.us-east-2
  }
  vpc_id       = module.vpc_us_east_2.vpc_id
  subnet_id    = module.vpc_us_east_2.public_subnet_ids[0]
  region       = "us-east-2"
  instance_type = var.instance_type
}