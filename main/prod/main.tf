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
}

