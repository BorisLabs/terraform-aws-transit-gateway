locals {
  tgw_id  = "${element(concat(aws_ec2_transit_gateway.this.*.id, list(var.tgw_id)), 0)}"
  tgw_arn = "${element(concat(aws_ec2_transit_gateway.this.*.arn, list(var.tgw_arn)), 0)}"
}

resource "aws_ec2_transit_gateway" "this" {
  count = "${var.create_tgw ? 1 : 0}"

  description = "${var.tgw_gateway_description}"

  amazon_side_asn                 = "${var.amazon_side_asn}"
  auto_accept_shared_attachments  = "${var.auto_accept_shared_attachments}"
  default_route_table_association = "${var.default_route_table_association}"
  default_route_table_propagation = "${var.default_route_table_propagation}"
  dns_support                     = "${var.dns_support}"

  vpn_ecmp_support = "${var.vpn_ecmp_support}"
  tags             = "${var.tgw_tags}"
}

# Creates a gateway route table and associates with the Gateway
resource "aws_ec2_transit_gateway_route_table" "this" {
  count = "${var.create_tgw ? 1 : 0}"

  transit_gateway_id = "${local.tgw_id}"

  tags = "${merge(var.default_tags, var.route_table_tags)}"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = "${var.attach_to_vpc || var.create_tgw ? 1 : 0}"

  vpc_id     = "${var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id}"
  subnet_ids = ["${split("," ,var.vpc_id != "" ? join(",", var.subnet_ids) : join(",", data.aws_subnet_ids.subnets.*.ids))}"]

  transit_gateway_id = "${local.tgw_id}"

  transit_gateway_default_route_table_association = "${var.tgw_route_table_association}"
  transit_gateway_default_route_table_propagation = "${var.tgw_route_table_propagation}"
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = "${var.create_tgw ? 1 : 0}"

  transit_gateway_attachment_id  = "${element(aws_ec2_transit_gateway_vpc_attachment.this.*.id, count.index)}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.this.id}"

  depends_on = ["aws_ec2_transit_gateway_vpc_attachment.this"]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = "${var.create_tgw ? 1 : 0}"

  transit_gateway_attachment_id  = "${element(aws_ec2_transit_gateway_vpc_attachment.this.*.id, count.index)}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.this.id}"

  depends_on = ["aws_ec2_transit_gateway_route_table.this"]
}

resource "aws_ec2_transit_gateway_route" "this" {
  count = "${var.create_tgw ? length(var.tgw_route) : 0}"

  destination_cidr_block         = "${element(var.tgw_route, count.index)}"
  transit_gateway_attachment_id  = "${element(aws_ec2_transit_gateway_vpc_attachment.this.*.id, count.index)}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.this.id}"
}

resource "aws_ram_resource_share" "this" {
  name                      = "transit-share"
  allow_external_principals = false

  tags = "${var.ram_share_tags}"
}

resource "aws_ram_resource_association" "this" {
  count = "${var.create_tgw && var.share_tgw ? 1 : 0}"

  resource_arn       = "${local.tgw_arn}"
  resource_share_arn = "${aws_ram_resource_share.this.arn}"
}

// Todo not really a thing at the moment leave switched off.
resource "aws_ram_principal_association" "this" {
  count = "${var.share_tgw ? 1 : 0}"

  principal          = "${data.aws_caller_identity.this.account_id}"
  resource_share_arn = "${aws_ram_resource_share.this.arn}"
}
