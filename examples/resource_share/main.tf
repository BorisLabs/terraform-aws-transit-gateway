resource "aws_ram_resource_share" "this" {
  name = "transit-share"

  allow_external_principals = true

  tags = {
    Environment = "Production"
    Resource = "Transit Gateway"
  }
}


provider "aws" {
  region = "eu-west-1"
}