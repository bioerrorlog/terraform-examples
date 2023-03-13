variable "name_prefix" {
  description = "The prefix of resource names."
  type        = string
  default     = "demo"

  validation {
    condition     = length(var.name_prefix) > 0
    error_message = "You must set name_prefix with the length > 0."
  }
}

variable "log_retention_in_days" {
  description = "the number of days you want to retain the log."
  type        = number
  default     = 90
}
