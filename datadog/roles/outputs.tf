// map(string)
output "role_ids" {
  value = { for r in data.datadog_roles.all.roles : r.name => r.id }
}
