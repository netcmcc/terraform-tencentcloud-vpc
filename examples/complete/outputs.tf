output "vpc_id" {
  description = "The id of vpc."
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The id of subnet."
  value       = module.vpc.subnet_ids
}

output "eni_subnet_ids" {
  description = "The id of ENI subnet."
  value       = module.vpc.eni_subnet_ids
}

output "route_table_id" {
  description = "The id of route table."
  value       = module.vpc.route_table_id
}
