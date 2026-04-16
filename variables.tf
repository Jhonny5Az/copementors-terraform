variable "loop-bucket" {
  type = set(string)
  default = ["bucket260325-1",
    "bucket260325-2",
  "bucket260325-3", ]
}
variable "enabled_static_website" {
  type    = bool
  default = false
}

variable "enabled_public_access" {
  type    = bool
  default = false
}

variable "enabled_cors_config" {
  type    = bool
  default = false
}