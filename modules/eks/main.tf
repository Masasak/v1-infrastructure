module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.18.0"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = local.vpc_id
  subnet_ids = local.public_subnets

  enable_irsa = true

  cluster_enabled_log_types = []
  create_cloudwatch_log_group = false

  eks_managed_node_group_defaults = {
    instance_types = [local.instance_type]
    capacity_type  = local.capacity_type
  }

  eks_managed_node_groups = {
    SnapVibe_node = {
      instance_types         = [local.instance_type]
      create_security_group  = false
      create_launch_template = true
      launch_template_name   = "SnapVibe-node-lt"

      min_size     = var.nodegroup_min_size
      max_size     = var.nodegroup_max_size
      desired_size = var.nodegroup_desired_size

      iam_role_additional_policies = {
        policy1 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_users = concat(
    [{
      userarn  = data.aws_caller_identity.current.arn
      username = local.current_username
      groups   = ["system:admin"]
    }],
    var.auth_users
  )
  aws_auth_roles = var.auth_roles

  aws_auth_accounts = [
    data.aws_caller_identity.current.account_id
  ]
}