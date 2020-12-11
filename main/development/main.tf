terraform {
  backend "gcs" {
    bucket  = "velan-terraform"
    prefix  = "terraform/state"
  }
}


provider "google" {
  project = "${var.gcp_project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

module "dev_google_service_account" {
  source = "../../modules/service_accounts"
  project = "${var.gcp_project}"



  ordermanagement_subscriber_email = var.ordermanagement_subscriber_email
  workload_identity_k8s_namespace = var.workload_identity_k8s_namespace
  workload_identity_k8s_service_account = var.workload_identity_k8s_service_account
  cd_service_account_name = var.cd_service_account_name
  cluster_service_account_name = var.cluster_service_account_name
  database_service_account_name = var.database_service_account_name
  dataflow_job_service_account_name = var.dataflow_job_service_account_name
  kubernetes_cluster_service_account_name = var.kubernetes_cluster_service_account_name
  kubernetes_deployment_service_account_name = var.kubernetes_deployment_service_account_name
  logging_service_account_name = var.logging_service_account_name
  networking_service_account_name = var.networking_service_account_name
  pubsubadmin_service_account_name = var.pubsubadmin_service_account_name
  pupservice_service_account_name = var.pupservice_service_account_name
  pupservice_sql_service_account_name = var.pupservice_sql_service_account_name
}

module "dev_google_network" {
  source = "../../modules/network"
  project = "${var.gcp_project}"
  region = var.region
  networking_serviceaccount_email = module.dev_google_service_account.networking_serviceaccount_email
}

module "dev_google_k8s_cluster" {
  source = "../../modules/gke_cluster"
  cluster_serviceaccount_email = module.dev_google_service_account.kubernetes_cluster_serviceaccount_email
  cluster_name = "velan"
  cluster_service_account_name = module.dev_google_service_account.kubernetes_cluster_serviceaccount_email
  location = ""
  project = ""
  region = ""
  vpc_network_name = ""
}

output "gcpnets" {
  value = module.dev_google_network.private_subnet
}

output "global_address_ranges" {
  value = module.dev_google_network.global_address_ranges
}
