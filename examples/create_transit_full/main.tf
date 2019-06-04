provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias   = "target-account"
  region  = "eu-west-1"
  profile = "account-to-share"
}

module "transit" {
  source = "../../"

  dns_support = "enable"

  tgw_tags = {
    Name  = "Tansit"
    Owner = "Cloud"
  }

  route_table_tags = {
    Name  = "Transit-Non-Default-Route-Table"
    Owner = "Cloud"
  }

  attach_to_vpc = false

  auto_accept_shared_attachments = "enable"

  providers = {
    "aws.share" = "aws.target-account"
  }
}
