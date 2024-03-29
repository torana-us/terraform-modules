resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_is_immutable ? "IMMUTABLE" : "MUTABLE"

  encryption_configuration {
    #tfsec:ignore:aws-ecr-repository-customer-key
    encryption_type = try(var.encryption_configuration.encryption_type, "AES256")
    kms_key         = try(var.encryption_configuration.kms_key, null)
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge({
    "Name" = var.name
  }, var.tags)
}

resource "aws_ecr_repository_policy" "this" {
  for_each   = var.policy != null ? { "policy" = var.policy } : {}
  policy     = var.policy
  repository = aws_ecr_repository.this.name
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "keep last 15 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 15
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

