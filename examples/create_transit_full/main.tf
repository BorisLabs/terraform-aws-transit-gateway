provider "aws" {
  region  = "eu-west-1"
  profile = "test-account-1"
}

provider "aws" {
  alias   = "target-account"
  region  = "eu-west-1"
  profile = "test-account-2"
}

module "transit" {
  source = "../../"

  tgw_dns_support = "enable"

  tgw_tags = {
    Name  = "Tansit"
    Owner = "Cloud"
  }

  route_table_tags = {
    Name  = "Transit-Non-Default-Route-Table"
    Owner = "Cloud"
  }

  attach_to_vpc = false

  tgw_auto_accept_shared_attachments = "enable"

  tgw_route_table_association = false
  tgw_route_table_propagation = false

  providers = {
    aws = aws
    aws.tgw_rt_owner  = aws.target-account
  }
}

