provider "google" {
  project = "terraform-447821"
  region  = "us-west1"
  zone    = "us-west1-a"
  credentials = var.GOOGLE_CREDENTIALS
}
