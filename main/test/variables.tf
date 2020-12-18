variable "gcp_project" {}
variable "region" {}
variable "zone" {}
variable "vpc_name" {}
variable "sa_name" {}
variable "subnet_cidr" {}
variable "key" {}
variable "iam_roles" {
  type = "map"
}