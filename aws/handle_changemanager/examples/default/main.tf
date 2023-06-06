resource "aws_vpc" "this" {
  cidr_block = "10.22.0.0/18"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, 1)
}

resource "aws_sns_topic" "this" {
  name = "from_change_manager"
}


module "handle_cm" {
  source = "../../"

  project_name = "example"
  vpc_id       = aws_vpc.this.id
  subnet_ids   = [aws_subnet.this.id]
  parameter_name    = "dummy"

  depends_on = [
    aws_sns_topic.this
  ]
}
