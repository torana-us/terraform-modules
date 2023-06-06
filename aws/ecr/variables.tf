variable "name" {
  type = string
}

variable "image_tag_is_immutable" {
  type    = bool
  default = true
}

variable "encryption_configuration" {
  type    = map(any)
  default = {}
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "policy" {
  type        = string
  default     = null
  description = "policy json"
}
