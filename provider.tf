terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }
  cloud {
    hostname     = "app.terraform.io"
    organization = "Masasak"
    workspaces {
      name = "snapvibe-IaC"
    }
  }
}

provider "aws" {
  region = local.region
}