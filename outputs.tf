output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.*[0].id
}

output "transit_gateway_arn" {
  value = aws_ec2_transit_gateway.this.*[0].arn
}

