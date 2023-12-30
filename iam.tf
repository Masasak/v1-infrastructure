module "load_balancer_controller_irsa_role" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name                              = "load-balancer-controller"
  attach_load_balancer_controller_policy = true
  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

resource "aws_iam_policy" "eks_nlb_create_policy" {
  name = "eks_nlb_create_policy"

  policy = {
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "kopsK8sNLBMasterPermsRestrictive"
            Effect = "Allow"
            Action = [
                "ec2:DescribeVpcs",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:CreateTargetGroup",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeLoadBalancerPolicies",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:SetLoadBalancerPoliciesOfListener"
            ]
            Resource = ["*"]
        },
        {
            Effect = "Allow"
            Action = [
                "ec2:DescribeVpcs",
                "ec2:DescribeRegions"
            ]
            Resource = "*"
        }
    ]
  }
}