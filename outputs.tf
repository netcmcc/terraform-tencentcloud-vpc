output "vpc_id" {
  description = "The id of vpc."
  value       = try(tencentcloud_vpc.this.0.id, null)
}

output "vpc_cidr" {
  description = "The CIDR block of vpc."
  value       = try(tencentcloud_vpc.this.0.cidr_block, null)
}

output "subnet_ids" {
  description = "The id of subnet."
  value       = tencentcloud_subnet.subnet.*.id
}

output "eni_subnet_ids" {
  description = "The id of ENI subnet."
  value       = tencentcloud_subnet.eni_subnet.*.id
}

output "route_table_id" {
  description = "The id of route table."
  value       = try(tencentcloud_route_table.this.0.id, null)
}

output "availability_zones" {
  value       = tencentcloud_subnet.subnet.*.availability_zone
  description = "The availability zone of subnet."
}

output "nat_gateway_eip" {
  value       = try(tencentcloud_eip.nat_eip.0.public_ip, null)
  description = "The EIP address associated with the NAT gateway."
}
