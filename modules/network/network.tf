provider "google" {
  project = var.project
  region  = var.region
  credentials = file("${path.module}/ancient-episode-282417-8027df4b43ea.json")
  impersonate_service_account = var.networking_serviceaccount_email
}

provider "google-beta" {
  project = var.project
  region  = var.region
  credentials = file("${path.module}/ancient-episode-282417-8027df4b43ea.json")
  impersonate_service_account = var.networking_serviceaccount_email
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A NETWORK TO DEPLOY THE CLUSTER TO
# ---------------------------------------------------------------------------------------------------------------------

module "vpc_network" {
  source = "git@git.build.ingka.ikea.com:terraform/gcp-networking.git//vpc-network?ref=v0.0.4"
  project     = var.project
  region      = var.region
  name_prefix = var.name_prefix
}

# enable access to google private services from the target network
module "gcp_csql_psa" {
  source = "../private-service-access"
  project_id = var.project
  prefix_length = var.prefix_length
  vpc_network = module.vpc_network.network_name
  depends_on = [module.vpc_network.network_name]
}

resource "null_resource" "dependency_setter" {
  depends_on = [module.gcp_csql_psa.peering_completed]
}

# Use a random suffix to prevent overlap in network names
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  networking_serviceaccount = data.terraform_remote_state.service_account.outputs
}
