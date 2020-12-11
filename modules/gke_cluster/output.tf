output "name" {
  # This may seem redundant with the `name` input, but it serves an important
  # purpose. Terraform won't establish a dependency graph without this to interpolate on.
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."

  value = module.gke_cluster.name
}

output "endpoint" {
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."

  sensitive = true
  value = module.gke_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."

  value = module.gke_cluster.cluster_ca_certificate
}
