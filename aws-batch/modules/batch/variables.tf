variable "sysid" {
  description = "System id"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC id for Batch compute resources"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids for Batch compute resources"
  type        = list(string)
}

variable "schedule_expression" {
  description = "Schedule expression for AWS Batch trigger"
  type        = string
  default     = "rate(5 minutes)"
}
