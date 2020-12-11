data "google_compute_network" "managed_services_network" {
  project                    = var.project_id
  name                       = var.vpc_network
}

resource "google_compute_global_address" "google_managed_services_range" {
  provider      = google-beta
  project       = var.project_id
  name          = "google-managed-services-${data.google_compute_network.managed_services_network.name}"
  purpose       = "VPC_PEERING"
  address       = var.address
  prefix_length = var.prefix_length
  ip_version    = var.ip_version
  labels        = var.labels
  address_type  = "INTERNAL"
  network       = data.google_compute_network.managed_services_network.self_link
}

data "google_compute_global_address" "google_managed_services_range_data" {
  provider      = google-beta
  project       = var.project_id
  name          = "google-managed-services-${data.google_compute_network.managed_services_network.name}"
  depends_on    = [data.google_compute_network.managed_services_network]
}

# Creates the peering with the producer network.
resource "google_service_networking_connection" "private_service_access" {
  provider                = google-beta
  network                 = google_compute_global_address.google_managed_services_range.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.google_managed_services_range.name]
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_service_networking_connection.private_service_access]
}

