terraform {
  required_version = ">= 1.2.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28"
    }
  }

  # backend設定そのものは記載しない
  backend "s3" {}
}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Project = "terraform-examples"
      Owner   = "bioerrorlog"
    }
  }
}
