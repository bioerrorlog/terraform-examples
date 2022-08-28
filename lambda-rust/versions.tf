terraform {
  required_version = ">= 1.2.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
