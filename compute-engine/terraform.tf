terraform {
    backend "gcs" {
      bucket = "hanalytics-bucket-tfstate_1"
      prefix = "compute-instance"
    }
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.7.0"
      }
    }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
//impersonate_service_account = var.tf_service_account
}