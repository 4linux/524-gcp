provider "google" {
  region  = var.default_region
  project = var.gcp_project
  credentials = file("~/.gcp/gcp-4linux-860390513fc7.json")
}