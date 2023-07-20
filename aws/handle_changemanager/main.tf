locals {
  lambda_name = "from_change_manager_sns_${var.project_name}"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = var.vpc_id
}

resource "aws_lambda_function" "this" {
  function_name    = local.lambda_name
  role             = module.lambda_role.role.arn
  filename         = "${path.module}/src/runner.zip"
  handler          = "runner"
  runtime          = "go1.x"
  source_code_hash = filebase64sha256("${path.module}/src/runner.zip")

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [data.aws_security_group.default.id]
  }

  environment {
    variables = {
      LOG_LEVEL      = "error"
      parameter_name = var.parameter_name
    }
  }
}

resource "aws_lambda_permission" "sns" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = data.aws_sns_topic.this.arn
}

module "lambda_role" {
  source = "../iam_role"

  # insert required variables here
  name = local.lambda_name
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  ]
  service_list = ["lambda.amazonaws.com"]
}

resource "aws_security_group" "ssm_vpc_endpoint" {
  name = "ssm-vpc-endpoint"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ssm" {
  security_group_id = aws_security_group.ssm_vpc_endpoint.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "self" {
  security_group_id = aws_security_group.ssm_vpc_endpoint.id
  reference_security_group_id = aws_security_group.ssm_vpc_endpoint.id
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.ssm_vpc_endpoint.id
  ip_protocol = "-1"
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_id              = var.vpc_id
  security_group_ids  = [aws_security_group.ssm_vpc_endpoint.id]
  subnet_ids          = var.subnet_ids
  private_dns_enabled = true

  tags = {
    "project" = var.project_name
  }
}


# 本当はdataでなくresourceで作成したいが
# torana-devにはortegaとmadrasがあるので
# 2つ作成すると名前がかぶってしまうのでdataで参照する
# (change_managerからSNS名を決め打たないとだめなので)
data "aws_sns_topic" "this" {
  name = "from_change_manager"
}

resource "aws_sns_topic_subscription" "lambda" {
  endpoint  = aws_lambda_function.this.arn
  protocol  = "lambda"
  topic_arn = data.aws_sns_topic.this.arn
}
