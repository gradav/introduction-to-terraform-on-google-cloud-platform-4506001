# Declare GOOGLE_CREDENTIALS as a variable
variable "GOOGLE_CREDENTIALS" {
  type        = string
  description = "The JSON credentials for the Google Cloud provider."
  sensitive   = true
}

# Configure the Google provider to use the credentials
provider "google" {
  project     = "terraform-447821"  # Ensure this matches your project ID
  region      = "us-west1"
  zone        = "us-west1-a"
  credentials = var.GOOGLE_CREDENTIALS
}

# Fetch the most recent Ubuntu image
data "google_compute_image" "ubuntu" {
  most_recent = true
  project     = "ubuntu-os-cloud"
  family      = "ubuntu-2204-lts"
}

# Define the Google Compute Engine instance
resource "google_compute_instance" "web" {
  name         = "web"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    subnetwork = "default"
    access_config {
      # Leave empty for dynamic public IP
    }
  }
}
