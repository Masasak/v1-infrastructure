resource "helm_release" "this" {
  name       = var.name
  namespace  = try(var.namespace)
  repository = var.repository
  chart      = var.chart
  version    = var.chart_version

  create_namespace  = var.create_namespace
}