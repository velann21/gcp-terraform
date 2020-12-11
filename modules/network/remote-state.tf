data "terraform_remote_state" "service_account" {
  # This would be remote block that you would use for this in a real env.
  backend = "gcs"
  config = {
   bucket  = "velan-terraform"
   prefix  = "terraform/state"
 }
}