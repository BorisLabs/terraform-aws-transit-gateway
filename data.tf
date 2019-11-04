data "aws_caller_identity" "this" {
}

data "aws_vpc" "default" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id
}

data "aws_subnet_ids" "subnets" {
  count  = var.vpc_id == "" ? 1 : 0
  vpc_id = data.aws_vpc.default.id
}

