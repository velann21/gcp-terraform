
# ---------------------------------------------------------------------------------------------------------------------
# PREPARE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------

provider "google" {
  project = var.project
  region  = var.region
  credentials = file("${path.module}/ancient-episode-282417-abaa71253668.json")
  impersonate_service_account = var.cluster_serviceaccount_email
}

provider "google-beta" {
  project = var.project
  region  = var.region
  credentials = file("${path.module}/ancient-episode-282417-abaa71253668.json")
  impersonate_service_account = var.cluster_serviceaccount_email
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A PRIVATE CLUSTER IN GOOGLE CLOUD PLATFORM
# ---------------------------------------------------------------------------------------------------------------------

module "gke_cluster" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  source = "git@git.build.ingka.ikea.com:terraform/gcp-gke-cluster?ref=v0.1.3"

  name = var.cluster_name
  workload_identity_config = true

  project  = var.project
  location = var.location
  network  = local.network
  subnetwork_secondary_range_name_pods = local.subnetwork_secondary_range_name_pods
  subnetwork_secondary_range_name_services = local.subnetwork_secondary_range_name_services

  kubernetes_version = var.kubernetes_version

  # We're deploying the cluster in the 'public' subnetwork to allow outbound internet access
  # See the network access tier table for full details:
  # https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/vpc-network#access-tier
  subnetwork = local.public_subnetwork

  # When creating a private cluster, the 'master_ipv4_cidr_block' has to be defined and the size must be /28
  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  # To make testing easier, we keep the public endpoint available. In production, we highly recommend restricting access to only within the network boundary, requiring your users to use a bastion host or VPN.
  disable_public_endpoint = "false"

  # With a private cluster, it is highly recommended to restrict access to the cluster master
  # However, for testing purposes we will allow all inbound traffic.
  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "0.0.0.0/0"
          display_name = "all-for-testing"
        },
      ]
    },
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Prepare locals to keep the code cleaner
# ---------------------------------------------------------------------------------------------------------------------

locals {
  network               = data.terraform_remote_state.vpc_network.outputs.network
  public_subnetwork     = data.terraform_remote_state.vpc_network.outputs.public_subnetwork
  subnetwork_secondary_range_name_pods  = data.terraform_remote_state.vpc_network.outputs.public_subnetwork_secondary_range_name_pods
  subnetwork_secondary_range_name_services  = data.terraform_remote_state.vpc_network.outputs.public_subnetwork_secondary_range_name_services
  cluster_serviceaccount = data.terraform_remote_state.service_account.outputs.kubernetes_cluster_serviceaccount_email
}
