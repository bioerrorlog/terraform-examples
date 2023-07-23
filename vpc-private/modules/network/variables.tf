variable "sysid" {
  description = "System id"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_01" {
  description = "CIDR block and AZ for the private subnet 01"
  type = object({
    cidr = string
    az   = string
  })
  default = { cidr = "10.0.3.0/24", az = "ap-northeast-1a" }
}

variable "private_subnet_02" {
  description = "CIDR block and AZ for the private subnet 02"
  type = object({
    cidr = string
    az   = string
  })
  default = { cidr = "10.0.4.0/24", az = "ap-northeast-1c" }
}
