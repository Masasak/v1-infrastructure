variable "name" {
  type        = string
  description = "ecr repo name"
}

variable "is_scan_on_push" {
  type        = bool
  description = "immage scan on push to ecr(default is true)"
  default     = true
}