locals {
  tgw_id  = element(concat(aws_ec2_transit_gateway.this.*.id, [var.tgw_id]), 0)
  tgw_arn = element(concat(aws_ec2_transit_gateway.this.*.arn, [var.tgw_arn]), 0)

  tgw_attachment_id = element(concat(aws_ec2_transit_gateway_vpc_attachment.this.*.id, [var.tgw_attachment_id]), 0)

  tgw_route_rtb = element(concat(aws_ec2_transit_gateway_route_table.this.*.id, [var.alt_tgw_route_table_id]), 0)
}

resource "aws_ec2_transit_gateway" "this" {
  count = var.create_tgw ? 1 : 0

  description = var.tgw_gateway_description

  amazon_side_asn                 = var.tgw_amazon_side_asn
  auto_accept_shared_attachments  = var.tgw_auto_accept_shared_attachments
  default_route_table_association = var.tgw_default_route_table_association
  default_route_table_propagation = var.tgw_default_route_table_propagation
  dns_support                     = var.tgw_dns_support

  vpn_ecmp_support = var.tgw_vpn_ecmp_support
  tags             = var.tgw_tags
}

# Creates a gateway route table and associates with the Gateway
resource "aws_ec2_transit_gateway_route_table" "this" {
  count = var.create_tgw_route_table ? 1 : 0

  transit_gateway_id = local.tgw_id

  tags = merge(var.default_tags, var.route_table_tags)
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.attach_to_vpc ? 1 : 0

  vpc_id     = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id
  subnet_ids = var.vpc_id != "" ?  var.subnet_ids : data.aws_subnet_ids.subnets.*[0].ids

  transit_gateway_id = local.tgw_id

  transit_gateway_default_route_table_association = var.tgw_route_table_association
  transit_gateway_default_route_table_propagation = var.tgw_route_table_propagation
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.create_tgw_route_table && (var.attach_to_vpc || var.add_tgw_route_table_association) ? 1 : 0

  transit_gateway_attachment_id = local.tgw_attachment_id

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[0].id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.this]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = var.create_tgw_route_table && (var.attach_to_vpc || var.add_tgw_route_table_propagation) ? 1 : 0

  transit_gateway_attachment_id = local.tgw_attachment_id

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[0].id

  depends_on = [aws_ec2_transit_gateway_route_table.this]
}

resource "aws_ec2_transit_gateway_route_table_association" "this_cross_account" {
  count = var.attach_to_vpc && !var.create_tgw_route_table && var.use_cross_account_tgw_route_table ? 1 : 0

  provider = aws.tgw_rt_owner

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  transit_gateway_route_table_id = var.alt_tgw_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this_cross_account" {
  count = var.attach_to_vpc && !var.create_tgw_route_table && var.use_cross_account_tgw_route_table ? 1 : 0

  provider = aws.tgw_rt_owner

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  transit_gateway_route_table_id = var.alt_tgw_route_table_id
}

resource "aws_ec2_transit_gateway_route" "this" {
  count = var.create_tgw_routes ? length(var.tgw_route) : 0

  destination_cidr_block         = var.tgw_route[count.index]
  transit_gateway_attachment_id  = local.tgw_attachment_id
  transit_gateway_route_table_id = local.tgw_route_rtb
}

resource "aws_ram_resource_share" "this" {
  count = var.share_tgw ? 1 : 0

  name                      = var.ram_share_name
  allow_external_principals = false
  tags                      = var.ram_share_tags
}

resource "aws_ram_resource_association" "this" {
  count = var.create_tgw && var.share_tgw ? 1 : 0

  resource_arn       = local.tgw_arn
  resource_share_arn = aws_ram_resource_share.this[0].arn
}

// Todo not really a thing at the moment leave switched off.
resource "aws_ram_principal_association" "this" {
  count = var.share_tgw ? 1 : 0

  principal          = data.aws_caller_identity.this.account_id
  resource_share_arn = aws_ram_resource_share.this[0].arn
}

