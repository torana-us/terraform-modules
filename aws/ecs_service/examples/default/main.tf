module "test_service" {
  source = "../../"

  service_name                      = "test-service"
  cluster_id                        = module.test_cluster.cluster.id
  desired_count                     = 0
  health_check_grace_period_seconds = 60
  load_balancers                    = []
  network_configuration = {
    assign_public_ip = true
    security_groups  = [data.aws_security_group.default.id]
    subnets          = [aws_subnet.this.id]
  }
  capacity_provider_strategies = [
    {
      capacity_provider = "FARGATE_SPOT"
      base              = 0
      weight            = 1
    }
  ]

  task_name = "test-task"
  container_definitions = jsonencode([
    {
      command                = []
      essential              = true
      image                  = "busybox:uclibc"
      mountPoints            = []
      name                   = "test-task-def"
      portMappings           = []
      readonlyRootFilesystem = false
      secrets                = []
      ulimits                = []
      volumesFrom            = []
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "test"
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "test"
        }
      }
    }
  ])

  cpu                = 256
  memory             = 512
  execution_role_arn = module.task_execution_role.role.arn
  task_role_arn      = module.task_role.role.arn
}

module "test_cluster" {
  source = "../../../ecs_cluster"

  name                       = "test-cluster"
  container_insights_enabled = false
  default_capacity_provider_strategies = [
    {
      capacity_provider = "FARGATE_SPOT"
      base              = 0
      weight            = 1
    }
  ]

  cluster_configuration = {
    execute_command_configuration = {
      logging           = "DEFAULT"
      kms_key_id        = null
      log_configuration = null
    }
  }
}

resource "aws_vpc" "this" {
  cidr_block           = "10.22.0.0/18"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, 1)
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.this.id
}

data "aws_iam_policy_document" "ecs_task_execution" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name   = "ecs-task-execution-policy"
  policy = data.aws_iam_policy_document.ecs_task_execution.json
}

module "task_execution_role" {
  source       = "../../../iam_role"
  name         = "test_task_exec_role"
  service_list = ["ecs-tasks.amazonaws.com"]
  policy_arns  = [aws_iam_policy.ecs_task_execution_policy.arn]
}

data "aws_iam_policy_document" "ecs_exec" {
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_exec_policy" {
  name   = "ECSExecPolicy"
  policy = data.aws_iam_policy_document.ecs_exec.json
}

module "task_role" {
  source       = "../../../iam_role"
  name         = "test_task_role"
  service_list = ["ecs-tasks.amazonaws.com"]
  policy_arns = [
    aws_iam_policy.ecs_exec_policy.arn,
  ]
}
