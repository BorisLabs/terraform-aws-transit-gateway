output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.*.id
}

output "transit_gateway_arn" {
  value = aws_ec2_transit_gateway.this.*.arn
}

output "transit_route_table" {
  value = aws_ec2_transit_gateway_route_table.this.*.arn
}

output "aws_ec2_transit_gateway_vpc_attachment" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.*.arn
}
