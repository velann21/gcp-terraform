resource "google_service_account" "sa" {
  account_id   = "${var.service_account}-tf-sa"
  display_name = "${var.service_account}-tf-sa"
}

resource "google_service_account" "pubsub"{
  account_id   = "pubsub-sa"
  display_name = "pubsub-sa"
}

resource "google_service_account" "computeEngine"{
  account_id   = "computeengine-sa"
  display_name = "computeengine-sa"
}

resource "google_service_account_iam_binding" "pubsub_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", google_service_account.pubsub.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", google_service_account.sa.email),
  ]
}

resource "google_service_account_iam_binding" "pubsub_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", google_service_account.pubsub.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", google_service_account.sa.email),
  ]
}


resource "google_service_account_iam_binding" "computeEngine_impersonation_token" {
  service_account_id = format("projects/-/serviceAccounts/%s", google_service_account.computeEngine.email)
  role               = "roles/iam.serviceAccountTokenCreator"
  members = [
    format("serviceAccount:%s", google_service_account.sa.email),
  ]
}


resource "google_service_account_iam_binding" "computeEngine_impersonation_user" {
  service_account_id = format("projects/-/serviceAccounts/%s", google_service_account.computeEngine.email)
  role               = "roles/iam.serviceAccountUser"
  members = [
    format("serviceAccount:%s", google_service_account.sa.email),
  ]
}
