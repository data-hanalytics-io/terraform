variable "project_id" {
  type        = string
  description = "ID of the Google Project"  
}

variable "source_location" {
  type        = string
  description = "Source Dataset Location"
}

variable "destination_location" {
  type        = string
  description = "Destination Dataset Location"
}

variable "table_id" {
  type        = string
  description = "name of the table in the dataset"
}

variable "dataset_id" {
  type        = string
  description = "Name of the Dataset"
}

variable "bigquery_service_account" {
  type        = string
  description = "Service Account Email"
}
