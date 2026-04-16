# Input variable definitions

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "enabled_static_website" {
    type        = bool
  default     = false
}

variable "enabled_public_access" {
    type        = bool
  default     = false
}

variable "enabled_cors_config" {
    type        = bool
  default     = false
}
