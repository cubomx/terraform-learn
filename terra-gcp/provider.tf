provider "google" {
  project     = var.PROJECT_ID
  region      = var.REGION
  zone        = "us-west2-a"
}

provider "google-beta" {
}
