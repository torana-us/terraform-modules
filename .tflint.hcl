plugin "aws" {
    enabled = true
    version = "0.24.3"
    source = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
  module = true
}

rule "terraform_naming_convention" {
  enabled = true
}
