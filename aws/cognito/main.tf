resource "aws_cognito_user_pool" "this" {
  name = var.name

  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = 1
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_identity_provider" "this" {
  provider_details = {
    "authorize_scopes" = "profile email openid"
    "client_id"        = var.client_id
    "client_secret"    = var.client_secret
  }
  provider_name = "Google"
  provider_type = "Google"
  user_pool_id  = aws_cognito_user_pool.this.id

  attribute_mapping = {
    name     = "name"
    email    = "email"
    username = "sub"
  }

  lifecycle {
    ignore_changes = [
      provider_details["attributes_url"],
      provider_details["attributes_url_add_attributes"],
      provider_details["authorize_url"],
      provider_details["token_request_method"],
      provider_details["token_url"],
      provider_details["oidc_issuer"],
    ]
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "alb"
  user_pool_id = aws_cognito_user_pool.this.id

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "profile",
  ]
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  supported_identity_providers = ["Google", "COGNITO"]
  callback_urls                = var.callback_urls
  generate_secret              = true
}

