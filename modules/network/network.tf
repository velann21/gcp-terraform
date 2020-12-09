//resource "google_compute_network" "project-network" {
//  name = "${var.vpc_name}-network"
//  description = "This subnet is vpc2"
//  auto_create_subnetworks = "false"
//  routing_mode = "REGIONAL"
//
//}
//
//resource "google_compute_subnetwork" "public_subnet" {
//  name                     = "${var.sa_name}"
//  region = "europe-west4"
//  ip_cidr_range            = "192.168.0.0/16"
//  private_ip_google_access = false
//  network                  = "${google_compute_network.project-network.name}"
//}
//
//
//resource "google_compute_firewall" "allow-ssh-firewall" {
//  name = "vpc-2-allow-ssh"
//  network = "${google_compute_network.project-network.name}"
//  priority = 1000
//  direction = "INGRESS"
//  target_tags = ["publicinstance"]
//  source_ranges = ["${var.subnet_cidr}"]
//  allow {
//    protocol = "tcp"
//    ports    = ["22"]
//  }
//}
//
//output "subnet_name" {
//  value = "${google_compute_subnetwork.public_subnet.name}"
//}
//
//
//
