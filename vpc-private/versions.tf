terraform {
  required_version = "1.5.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
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
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Project = "terraform-examples"
    }
  }
}
