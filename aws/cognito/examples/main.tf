module "cognito" {
  source = "../"

  name             = "example"
  callback_urls    = ["https://example.com/oauth2/idpresponse"]
  client_id        = "example_id"
  client_secret    = "example_secret"
  user_pool_domain = "example-${random_string.example.result}"
}

resource "random_string" "example" {
  length      = 10
  special     = false
  numeric     = true
  min_numeric = 10
}