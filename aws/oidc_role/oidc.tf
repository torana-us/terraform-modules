resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"]
  url             = "https://token.actions.githubusercontent.com"
}

module "github_actions_role" {
  source = "../iam_role"

  name = var.role_name
  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  custom_assume_policy_jsons = [
    data.aws_iam_policy_document.github_actions.json
  ]
}

data "aws_iam_policy_document" "github_actions" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.this.arn
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repositories
    }
  }
}
