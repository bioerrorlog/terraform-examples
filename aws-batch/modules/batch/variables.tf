variable "sysid" {
  description = "System id"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids for Batch compute resources"
  type        = list(string)
}
