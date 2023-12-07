locals {
  region = "ap-northeast-2"

  name_prefix     = "SnapVibe"
  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b"]
  public_subnets  = ["10.0.0.0/20", "10.0.16.0/20"]
  private_subnets = ["10.0.128.0/20", "10.0.144.0/20"]
  vpc_cidr        = "10.0.0.0/16"
  vpc_ipv6_cidr   = "2001:db8::/32"
}