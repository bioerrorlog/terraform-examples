variable "name_prefix" {
  description = "The prefix of resource names."
  type        = string
  default     = "default"

  validation {
    condition     = length(var.name_prefix) > 0
    error_message = "You must set name_prefix with the length > 0."
  }
}
