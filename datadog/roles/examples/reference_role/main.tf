module "roles" {
  source = "../.."

}

output "role_ids" {
  value = module.roles.role_ids
}
