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
