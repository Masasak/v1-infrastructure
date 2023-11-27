locals {
  cluster_version = "1.27"
  node_type       = "t3.medium"
  capacity_type   = "ON_DEMAND"
}

data "aws_caller_identity" "current" {}

module "eksv2" {
  source                 = "./modules/eks-cluster-v2"

  name_prefix     = local.name_prefix_v2
  cluster_version = local.cluster_version
  instance_type   = local.node_type
  capacity_type   = local.capacity_type

  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnet_ids
  nodegroup_min_size     = 1
  nodegroup_max_size     = 3
  nodegroup_desired_size = 2


  auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/admin"
      username = "admin"
    }
  ]
  auth_roles = [
    {
      rolearn  = module.karpenter.irsa_arn
      username = "system:node:{{EC2PrivateDNSName}}"
    }
  ]
}