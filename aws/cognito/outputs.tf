output "user_pool" {
  value = {
    arn       = aws_cognito_user_pool.this.arn
    client_id = aws_cognito_user_pool_client.this.id
    domain    = aws_cognito_user_pool_domain.this.domain
  }
}
