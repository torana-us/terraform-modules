variable "role_name" {
  type        = string
  description = "IAM role name"
}

variable "github_repositories" {
  type        = set(string)
  description = "GitHub repository name, e.g. [\"repo:torana-us/terraform-modules:*\",]"
}
