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
  aws-load-balancer-controller-version   = "0.1.3"
  aws-load-balancer-controller-namespace = "kube-system"

  ingress-name      = "snapvibe-ingress"
  ingress-version   = "0.1.6"
  ingress-namespace = "default"
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

module "ingress" {
  source        = "./modules/helm"
  name          = local.ingress-name
  namespace     = local.ingress-namespace
  repository    = local.snapvibe-helm-repository
  chart         = local.ingress-name
  chart_version = local.ingress-version
}