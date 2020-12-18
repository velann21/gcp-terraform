variable "gcp_project" {}
variable "region" {}
variable "zone" {}
variable "vpc_name" {}
variable "subnet_cidr" {}
variable "key" {}
variable "iam_roles" {
  type = "map"
}
variable "child_sas" {
  type = set(string)
}

variable "root_sa_account" {}

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
  default     = "ikea-cloudfoundation-test"
}


variable "cluster_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "cluster_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "Example GKE Cluster Service Account managed by Terraform"
}

variable "cluster_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/storage.objectViewer",
    "roles/container.admin",
    "roles/compute.networkAdmin"
  ]
}

variable "networking_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "networking_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "Example GKE Cluster Service Account managed by Terraform"
}

variable "networking_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = [
    "roles/servicenetworking.networksAdmin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin"
  ]
}

variable "pupservice_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "pupservice_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "Service account for the pup-service app"
}

variable "pupservice_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/cloudsql.client", "roles/pubsub.publisher"]
}

variable "pubsubadmin_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "pubsubadmin_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "Service account for the pup-service app"
}

variable "pubsubadmin_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/pubsub.admin"]
}

variable "cd_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "cd_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "Service account executing infrastructure automations"
}

variable "cd_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/storage.admin", "roles/serviceusage.serviceUsageConsumer"]
}

variable "database_service_account_name" {
  description = "The name of the custom service account used for the cloud SQL database. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "database_service_account_description" {
  description = "A description of the custom service account used for the cloud SQL database."
  type        = string
  default     = "Service account executing infrastructure provisioning of database"
}

variable "database_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/cloudsql.admin"]
}

variable "logging_service_account_name" {
  description = "The name of the custom service account used for the cloud SQL database. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "logging_service_account_description" {
  description = "A description of the custom service account used for the cloud SQL database."
  type        = string
  default     = "Service account executing infrastructure provisioning of database"
}

variable "logging_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/logging.admin"]
}

variable "dataflow_job_service_account_name" {
  description = "The name of the custom service account used for the dataflow job. This parameter is limited to a maximum of 28 characters."
  type        = string

}

variable "dataflow_job_service_account_description" {
  description = "A description of the custom service account used for the dataflow job."
  type        = string
  default     = "Service account executing infrastructure provisioning of dataflow job"
}

variable "dataflow_job_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/dataflow.admin"]
}

variable "kubernetes_cluster_service_account_name" {
  description = "The name of the custom service account used for the kubernetes cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "kubernetes_cluster_service_account_description" {
  description = "A description of the custom service account used for the kubernetes cluster."
  type        = string
  default     = "Service account executing infrastructure provisioning of database"
}

variable "kubernetes_cluster_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/container.clusterAdmin", "roles/compute.networkAdmin", "roles/iam.serviceAccountUser"]
}

variable "kubernetes_deployment_service_account_name" {
  description = "The name of the custom service account used for the kubernetes deployment. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "kubernetes_deployment_service_account_description" {
  description = "A description of the custom service account used for the kubernetes deployment."
  type        = string
  default     = "Service account executing infrastructure provisioning of database"
}

variable "kubernetes_deployment_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/container.admin"]
}

variable "pupservice_sql_service_account_name" {
  description = "The name of the custom service account used for connecting the kubernetes engine with the database. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "pupservice_sql_service_account_description" {
  description = "A description of the custom service account used for the kubernetes database connection."
  type        = string
  default     = "Service account executing infrastructure provisioning of database"
}

variable "pupservice_sql_service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default = ["roles/cloudsql.client"]
}

variable "ordermanagement_subscriber_email" {
  type        = string
  description = "The service account email of the order management topic subscriber."
}

variable "workload_identity_k8s_namespace" {
  type        = string
  description = "The service account email of the order management topic subscriber."
}

variable "workload_identity_k8s_service_account" {
  type        = string
  description = "The service account email of the order management topic subscriber."
}

variable "location" {
  default = "us-central1"
}

variable "kubernetes_version" {
  default = "1.15"
}

variable "cluster_name" {
  default = "pupmanager-us-central1-prod"
}


