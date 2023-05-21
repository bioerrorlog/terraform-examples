terraform {
  required_version = ">= 1.2.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28"
    }
  }

  # backend "s3" {
  #   bucket         = "mybucket"
  #   key            = "demo/terraform.state"
  #   region         = "ap-northeast-1"
  #   dynamodb_table = "demo-terraform-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
}
