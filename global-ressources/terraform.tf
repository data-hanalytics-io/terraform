terraform {
    backend "gcs" {
      bucket = "hanalytics-bucket-tfstate_1"
      prefix = "global-resources"
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
//impersonate_service_account = var.tf_service_account
}