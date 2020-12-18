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

module "prod_google_service_account" {
  source = "../../modules/service_accounts"
  service_account = "${var.sa_name}"
  project = "${var.gcp_project}"
  cd_service_account_name = ""
  cluster_service_account_name = ""
  database_service_account_name = ""
  dataflow_job_service_account_name = ""
  kubernetes_cluster_service_account_name = ""
  kubernetes_deployment_service_account_name = ""
  logging_service_account_name = ""
  networking_service_account_name = ""
  ordermanagement_subscriber_email = ""
  pubsubadmin_service_account_name = ""
  pupservice_service_account_name = ""
  pupservice_sql_service_account_name = ""
  workload_identity_k8s_namespace = ""
  workload_identity_k8s_service_account = ""
}

