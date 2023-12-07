provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = module.eks.cluster_ca_certificate
    token                  = module.eks.cluster_auth_token
  }
}

locals {
  snapvibe-helm-repository = "https://masasak.github.io/v1-kube-resource"

  argocd-name      = "argocd"
  argocd-version   = "0.1.0"
  argocd-namespace = "argocd"

  aws-load-balancer-controller-name      = "aws-load-balancer-controller"
  aws-load-balancer-controller-version   = "0.1.0"
  aws-load-balancer-controller-namespace = "kube-system"
}

module "argocd" {
  source        = "./modules/helm"
  name          = local.argocd-name
  namespace     = local.argocd-namespace
  repository    = local.snapvibe-helm-repository
  chart         = local.argocd-name
  chart_version = local.argocd-version
}

module "aws-load-balancer-controller" {
  source        = "./modules/helm"
  name          = local.aws-load-balancer-controller-name
  namespace     = local.aws-load-balancer-controller-namespace
  repository    = local.snapvibe-helm-repository
  chart         = local.aws-load-balancer-controller-name
  chart_version = local.aws-load-balancer-controller-version
}