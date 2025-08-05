terraform {
  required_version = ">= 1.12.2"
  required_providers {
    aws   = ">=6.6.0"
    local = ">=2.5.3"
  }
  backend "s3" {
    bucket = "fc-hrsc-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "fc-hrsc-vpc" {
  source         = "./modules/vpc"
  prefix         = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "fc-hrsc-eks" {
  source            = "./modules/eks"
  prefix            = var.prefix
  vpc_id            = module.fc-hrsc-vpc.aws_vpc_id
  subnet_ids        = module.fc-hrsc-vpc.aws_subnet_ids
  cluster_name      = var.cluster_name
  desired_size      = var.desired_size
  min_size          = var.min_size
  max_size          = var.max_size
  retention_in_days = var.retention_in_days
}
