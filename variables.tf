variable "tgw_amazon_side_asn" {
  description = "ASN of AWS Side of a BGP Session"
  default     = "64512"
}

variable "tgw_auto_accept_shared_attachments" {
  description = "Whether resource requests are automatically accepted"
  default     = "disable"
}

variable "tgw_default_route_table_association" {
  description = "Whether resource attachments are automatically associated with the default association route table"
  default     = "disable"
}

variable "tgw_default_route_table_propagation" {
  description = "Whether resource attachments automatically propagate routes to the default propagation route table"
  default     = "disable"
}

variable "tgw_gateway_description" {
  description = "Description of the Gateway"
  default     = ""
}

variable "create_tgw" {
  description = "Create a transit gateway or not"
  default     = true
}

variable "share_tgw" {
  description = "Share the Gateway using AWS RAM resource"
  default     = false
}

variable "tgw_id" {
  description = "Provide a TGW To use"
  default     = ""
}

variable "tgw_arn" {
  description = "Provide a TGW ARN works in conjunction with share_transit_gateway"
  default     = ""
}

variable "tgw_dns_support" {
  description = "Whether DNS support is enabled"
  default     = "enable"
}

variable "tgw_tags" {
  description = "Key Value Tags for the EC2 Transit Gateway"
  default     = {}

  type = map(string)
}

variable "tgw_vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath protocol is enabled"
  default     = "disable"
}

variable "attach_to_vpc" {
  description = "Attach the transit gateway to a VPC"
  default     = false
}

variable "vpc_id" {
  description = "VPC ID to attach gateway to"
  default     = ""
}

variable "subnet_ids" {
  description = "List of Subnet IDS for Gateway Attachment when attachment is for VPC"
  default     = []

  type = list(string)
}

variable "default_tags" {
  description = "Default Tags which are merged into resource tags"
  default     = {}

  type = map(string)
}

variable "route_table_tags" {
  description = "Key Value tags for EC2 Transit Gateway Route table"
  default     = {}

  type = map(string)
}

variable "ram_share_tags" {
  description = "Tags for RAM Resource Share"
  default     = {}

  type = map(string)
}

variable "ram_share_name" {
  description = "Name of the RAM Resource Share"
  default     = ""
}

variable "tgw_route" {
  description = "List of CIDR blocks to add to a transit gateway route table"
  default     = []

  type = list(string)
}

variable "tgw_route_table_association" {
  description = "TGW default Route association"
  default     = false
}

variable "tgw_route_table_propagation" {
  description = "TGW Default Route properation"
  default     = false
}

variable "create_tgw_route_table" {
  description = "Whether to create a route table associated with TGW"
  default     = false
}

variable "use_cross_account_tgw_route_table" {
  description = "Whether to associate Transit Gateawy Route Table in different account with the VPC Attachment created here"
  default     = false
}

variable "alt_tgw_route_table_id" {
  description = "ID of TGW Route Table cross account. Also used as RTB to add routes to."
  default     = ""
}

variable "add_tgw_route_table_association" {
  description = "Whether to associate TGW Route Table with an attachment"
  default     = ""
}
variable "add_tgw_route_table_propagation" {
  description = "Whether to associate TGW Route Table with an attachment"
  default     = ""
}

variable "tgw_attachment_id" {
  description = "ID of TGW Attachment to associate or propagate with Route Table"
  default     = ""
}

variable "create_tgw_routes" {
  description = "Whether to create tgw routes."
  default     = false
}