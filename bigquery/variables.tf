variable "project_id" {
  type        = string
  description = "ID of the Google Project"  
}

variable "location" {
  type        = string
  description = "Default Location"
  default     = "US"
}

variable "table_id" {
  type        = string
  description = "name of the table in the dataset"
}

variable "dataset_id" {
  type        = string
  description = "Name of the Dataset"
}