//resource "google_service_account" "root_sa" {
//  account_id   = "${var.root_service_account}"
//  display_name = "${var.root_service_account}"
//}
//
//resource "google_service_account" "sub_sa"{
//  account_id   = each.value
//  display_name = each.value
//  for_each = toset("${var.child_service_accounts}")
//}
//
//
//resource "google_service_account_iam_binding" "impersonation_token" {
//  for_each = "${var.child_service_accounts_email}"
//  service_account_id = format("projects/-/serviceAccounts/%s", each.value["email"])
//  role               = "roles/iam.serviceAccountTokenCreator"
//  members = [
//    format("serviceAccount:%s", google_service_account.root_sa.email),
//  ]
//}
//
//resource "google_service_account_iam_binding" "impersonation_user" {
//  for_each = "${var.child_service_accounts_email}"
//  service_account_id = format("projects/-/serviceAccounts/%s", each.value["email"])
//  role               = "roles/iam.serviceAccountUser"
//  members = [
//    format("serviceAccount:%s", google_service_account.root_sa.email),
//  ]
//}
//







# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT TO USE WITH THE GKE CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

module "gke_node_pool_serviceaccount" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.cluster_service_account_name
  project               = var.project
  description           = var.cluster_service_account_description
  service_account_roles = var.cluster_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR SETTING UP NETWORKING
# ---------------------------------------------------------------------------------------------------------------------

module "networking_serviceaccount" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.networking_service_account_name
  project               = var.project
  description           = var.networking_service_account_description
  service_account_roles = var.networking_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE ADMINISTRATION OF PUB/SUB TOPICS AND SUBSCRIPTIONS
# ---------------------------------------------------------------------------------------------------------------------

module "pubsub_serviceaccount" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.pubsubadmin_service_account_name
  project               = var.project
  description           = var.pubsubadmin_service_account_description
  service_account_roles = var.pubsubadmin_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE PUP-SERVICE APP
# ---------------------------------------------------------------------------------------------------------------------

module "pupservice_serviceaccount" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.pupservice_service_account_name
  project               = var.project
  description           = var.pupservice_service_account_description
  service_account_roles = var.pupservice_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE CD PIPELINES
# ---------------------------------------------------------------------------------------------------------------------

module "cd_serviceaccount" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.cd_service_account_name
  project               = var.project
  description           = var.cd_service_account_description
  service_account_roles = var.cd_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE CLOUD SQL DATABASE
# ---------------------------------------------------------------------------------------------------------------------

module "database_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.database_service_account_name
  project               = var.project
  description           = var.database_service_account_description
  service_account_roles = var.database_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE SPLUNK LOGGING
# ---------------------------------------------------------------------------------------------------------------------

module "logging_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.logging_service_account_name
  project               = var.project
  description           = var.logging_service_account_description
  service_account_roles = var.logging_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR DATAFLOW
# ---------------------------------------------------------------------------------------------------------------------

module "dataflow_job_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.dataflow_job_service_account_name
  project               = var.project
  description           = var.dataflow_job_service_account_description
  service_account_roles = var.dataflow_job_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE KUBERNETES CLUSTER CREATOR
# ---------------------------------------------------------------------------------------------------------------------

module "kubernetes_cluster_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.kubernetes_cluster_service_account_name
  project               = var.project
  description           = var.kubernetes_cluster_service_account_description
  service_account_roles = var.kubernetes_cluster_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE KUBERNETES DEPLOYMENTS
# ---------------------------------------------------------------------------------------------------------------------

module "kubernetes_deployment_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.kubernetes_deployment_service_account_name
  project               = var.project
  description           = var.kubernetes_deployment_service_account_description
  service_account_roles = var.kubernetes_deployment_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CUSTOM SERVICE ACCOUNT FOR THE KUBERNETES DEPLOYMENTS
# ---------------------------------------------------------------------------------------------------------------------

module "pupservice_sql_service_account" {
  source = "git@git.build.ingka.ikea.com:/terraform/gcp-service-account.git?ref=v0.0.1"

  name                  = var.pupservice_sql_service_account_name
  project               = var.project
  description           = var.pupservice_sql_service_account_description
  service_account_roles = var.pupservice_sql_service_account_roles
}

# ---------------------------------------------------------------------------------------------------------------------
# ALLOW THE CD SERVICE ACCOUNT TO IMPERSONATE OTHER SERVICE ACCOUNTS
# ---------------------------------------------------------------------------------------------------------------------
resource "google_service_account_iam_binding" "pubsub_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.pubsub_serviceaccount.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "pubsub_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.pubsub_serviceaccount.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "gke_node_pool_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.gke_node_pool_serviceaccount.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "gke_node_pool_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.gke_node_pool_serviceaccount.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "networking_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.networking_serviceaccount.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "networking_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.networking_serviceaccount.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "database_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.database_service_account.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "database_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.database_service_account.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "logging_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.logging_service_account.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "logging_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.logging_service_account.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "dataflow_job_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.dataflow_job_service_account.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "dataflow_job_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.dataflow_job_service_account.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "kubernetes_cluster_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.kubernetes_cluster_service_account.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "kubernetes_cluster_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.kubernetes_cluster_service_account.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "kubernetes_deployment_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.kubernetes_deployment_service_account.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_service_account_iam_binding" "kubernetes_deployment_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", module.kubernetes_deployment_service_account.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", module.cd_serviceaccount.email),
  ]
}

resource "google_project_iam_binding" "iam-topic-subscriber-remote" {
  project = var.project
  role    = "roles/pubsub.subscriber"
  members = [
    "serviceAccount:${var.ordermanagement_subscriber_email}"
  ]
}

//resource "google_service_account_iam_binding" "workload_identity_impersonation_user" {
//  service_account_id = format("projects/-/serviceAccounts/%s", module.pupservice_serviceaccount.email)
//  role               = "roles/iam.workloadIdentityUser"
//  members = [
//    format("serviceAccount:%s.svc.id.goog[%s/%s]", var.project, var.workload_identity_k8s_namespace, var.workload_identity_k8s_service_account),
//  ]
//}

