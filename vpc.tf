module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = local.vpc_cidr
  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  name_prefix     = local.name_prefix

  public_subnet_tags = {
    "kubernetes.io/role/elb"                 = "1",
    "kubernetes.io/cluster/SnapVibe-cluster" = "owned"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"        = "1",
    "kubernetes.io/cluster/SnapVibe-cluster" = "owned"
  }
}