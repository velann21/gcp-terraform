

//resource "google_compute_instance" "public-instance" {
//  machine_type = "n1-standard-1"
//  name = "public-instance"
//  tags          = ["publicinstance"]
//  zone          =   "${format("%s","${var.region}-b")}"
//  boot_disk {
//    initialize_params {
//      image     =  "centos-7-v20180129"
//    }
//  }
//  network_interface {
//    subnetwork = "${var.sa_name}"
//    access_config {
//
//      // Ephemeral IP
//    }
//  }
//  }