variable "name" {
  type = string
}

variable "callback_urls" {
  type = set(string)
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "user_pool_domain" {
  type = string
}
