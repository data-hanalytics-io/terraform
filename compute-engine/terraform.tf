terraform {
    required_version = ">= 1.3.0, < 2.0.0"
    backend "gcs" {
      bucket = "hanalytics-bucket-tfstate"
      prefix = "compute-instance"
    }
    required_providers {
        google   = "= 4.6.0"
    }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
//impersonate_service_account = var.tf_service_account
}