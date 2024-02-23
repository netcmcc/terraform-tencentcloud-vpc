output "vpc_id" {
  description = "The id of vpc."
  value       = tencentcloud_vpc.this.*.id
}

output "vpc_cidr" {
  description = "The CIDR block of vpc."
  value       = tencentcloud_vpc.this.*.cidr_block
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
  value       = tencentcloud_route_table.this.*.id
}

output "availability_zones" {
  value       = tencentcloud_subnet.subnet.*.availability_zone
  description = "The availability zone of subnet."
}

output "nat_gateway_eip" {
  value       = tencentcloud_eip.nat_eip.*.public_ip
  description = "The EIP address associated with the NAT gateway."
}
