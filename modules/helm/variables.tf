variable "repository" {
  type = string
}
variable "name" {
  type = string
}
variable "namespace" {
  type = string
  default = "default"
}
variable "chart" {
  type = string
}
variable "chart_version" {
  type = string
}
variable "create_namespace" {
  type = bool
  default = true
}