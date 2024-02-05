module "example" {
  source              = "../"
  github_repositories = ["repo:torana-us/terraform-modules:*"]
  role_name           = "github_actions_role_example"
}
