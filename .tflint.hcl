plugin "aws" {
    enabled = true
    version = "0.25.0"
    source = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
  module = true
}

rule "terraform_naming_convention" {
  enabled = true
}
