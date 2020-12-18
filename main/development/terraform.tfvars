region = "europe-west1"
zone = "europe-west1-d"
gcp_project = "ancient-episode-282417"
vpc_name = "newvpc"
child_sas = [
"pubsub",
"computeengine",
"cluster",
"databases"
]
subnet_cidr= "192.168.0.1/24"
key = "as"
iam_roles = {
  role1 = "roles/storage.objectViewer"
  role2 = "roles/logging.logWriter"
}

root_sa_account = "root-sa"
project = "ingka-dsm-acm-dev"

cluster_service_account_name = "pupmanager-gke-node-pool-sa"
cluster_service_account_description = "gke-node-pool service account for pupmanager"
networking_service_account_name = "vpc-networking"
networking_service_account_description = "networking & vpc service account for pupmanager"
pupservice_service_account_name = "pup-service"
pupservice_service_account_description = "Service account for the pup-service app"
pubsubadmin_service_account_name = "pubsub-adm"
pubsubadmin_service_account_description = "Pub/Sub Admin"
database_service_account_name = "database-adm-dev"
database_service_account_description = "Database Admin"
logging_service_account_name = "logging-adm-dev"
logging_service_account_description = "Logging Admin"
dataflow_job_service_account_name = "dataflow-adm-dev"
dataflow_job_service_account_description = "Dataflow Admin"
kubernetes_cluster_service_account_name = "kubernetes-cluster-adm-dev"
kubernetes_cluster_service_account_description = "Kubernetes Cluster Admin"
kubernetes_deployment_service_account_name = "kubernetes-deployment-adm-dev"
kubernetes_deployment_service_account_description = "Kubernetes Deployment Admin"
pupservice_sql_service_account_name = "pupservice-sql"
pupservice_sql_service_account_description = "Pick-Up-Point Service Admin"
cd_service_account_name = "continuous-delivery"
cd_service_account_description = "Execute infrastructure automation"
ordermanagement_subscriber_email = "pupmanagertopic@ingka-fulfilment-ordermgt-dev.iam.gserviceaccount.com"
workload_identity_k8s_namespace = "pupmanager"
workload_identity_k8s_service_account = "pupmanager"
