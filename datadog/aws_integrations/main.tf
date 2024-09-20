resource "datadog_integration_aws" "this" {
  account_id = var.aws_account_id
  role_name  = var.role_name

  excluded_regions = [
    "af-south-1",
    "ap-east-1",
    "ap-northeast-2",
    "ap-northeast-3",
    "ap-south-1",
    "ap-south-2",
    "ap-southeast-1",
    "ap-southeast-2",
    "ap-southeast-3",
    "ap-southeast-4",
    "ap-southeast-5",
    "ca-central-1",
    "ca-west-1",
    "eu-central-1",
    "eu-central-2",
    "eu-north-1",
    "eu-south-1",
    "eu-south-2",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "il-central-1",
    "me-central-1",
    "me-south-1",
    "sa-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2",
  ]

  account_specific_namespace_rules = {
    "api_gateway"                    = false
    "application_elb"                = false
    "apprunner"                      = false
    "appstream"                      = false
    "appsync"                        = false
    "athena"                         = false
    "auto_scaling"                   = false
    "backup"                         = false
    "bedrock"                        = false
    "billing"                        = false
    "budgeting"                      = false
    "certificatemanager"             = false
    "cloudfront"                     = false
    "cloudhsm"                       = false
    "cloudsearch"                    = false
    "cloudwatch_events"              = false
    "cloudwatch_logs"                = false
    "codebuild"                      = false
    "codewhisperer"                  = false
    "cognito"                        = false
    "connect"                        = false
    "directconnect"                  = false
    "dms"                            = false
    "documentdb"                     = false
    "dynamodb"                       = false
    "dynamodbaccelerator"            = false
    "ebs"                            = false
    "ec2"                            = false
    "ec2api"                         = false
    "ec2spot"                        = false
    "ecr"                            = false
    "ecs"                            = false
    "efs"                            = false
    "elasticache"                    = false
    "elasticbeanstalk"               = false
    "elasticinference"               = false
    "elastictranscoder"              = false
    "elb"                            = false
    "es"                             = false
    "firehose"                       = false
    "fsx"                            = false
    "gamelift"                       = false
    "globalaccelerator"              = false
    "glue"                           = false
    "inspector"                      = false
    "iot"                            = false
    "keyspaces"                      = false
    "kinesis"                        = false
    "kinesis_analytics"              = false
    "kms"                            = false
    "lambda"                         = false
    "lex"                            = false
    "mediaconnect"                   = false
    "mediaconvert"                   = false
    "medialive"                      = false
    "mediapackage"                   = false
    "mediastore"                     = false
    "mediatailor"                    = false
    "memorydb"                       = false
    "ml"                             = false
    "mq"                             = false
    "msk"                            = false
    "mwaa"                           = false
    "nat_gateway"                    = false
    "neptune"                        = false
    "network_elb"                    = false
    "networkfirewall"                = false
    "networkmonitor"                 = false
    "opsworks"                       = false
    "polly"                          = false
    "privatelinkendpoints"           = false
    "privatelinkservices"            = false
    "rds"                            = false
    "rdsproxy"                       = false
    "redshift"                       = false
    "rekognition"                    = false
    "route53"                        = false
    "route53resolver"                = false
    "s3"                             = false
    "s3storagelens"                  = false
    "sagemaker"                      = false
    "sagemakerendpoints"             = false
    "sagemakerlabelingjobs"          = false
    "sagemakermodelbuildingpipeline" = false
    "sagemakerprocessingjobs"        = false
    "sagemakertrainingjobs"          = false
    "sagemakertransformjobs"         = false
    "sagemakerworkteam"              = false
    "service_quotas"                 = false
    "ses"                            = false
    "shield"                         = false
    "sns"                            = false
    "step_functions"                 = false
    "storage_gateway"                = false
    "swf"                            = false
    "textract"                       = false
    "transitgateway"                 = false
    "translate"                      = false
    "trusted_advisor"                = false
    "usage"                          = false
    "vpn"                            = false
    "waf"                            = false
    "wafv2"                          = false
    "workspaces"                     = false
    "xray"                           = false
  }

  host_tags = [
    "aws_account_name:${var.aws_account_name}",
  ]
}
