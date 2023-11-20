terraform {
    required_version = ">= 1.3.0, < 2.0.0"
    backend "gcs" {
      bucket = "hanalytics-bucket-tfstate"
      prefix = "global-resources/"
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