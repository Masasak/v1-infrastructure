terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
  alias  = "seoul"
}