
output "network" {
  description = "A reference (self_link) to the VPC network"
  value       = module.vpc_network.network
}

output "network_name" {
  description = "Name of the VPC network"
  value       = module.vpc_network.network_name
}

output "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork"
  value       = module.vpc_network.public_subnetwork
}


output "public_subnetwork_secondary_range_name_pods" {
  value = module.vpc_network.public_subnetwork_secondary_range_name_pods
}

output "public_subnetwork_secondary_range_name_services" {
  value = module.vpc_network.public_subnetwork_secondary_range_name_services
}

output "public" {
  description = "The network tag string used for the public access tier"
  value       = module.vpc_network.public
}

output "private" {
  description = "The network tag string used for the private access tier"
  value       = module.vpc_network.private
}

output "private_subnet" {
  value = module.gcp_csql_psa.print-subnet1
}

output "global_address_ranges" {
  value = module.gcp_csql_psa.global_address_ranges_data
}
