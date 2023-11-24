variable "project_id" {
  type        = string
  description = "ID of the Google Project"  
}

variable "region" {
  type        = string
  description = "Default Region"
  default     = "us-central1"
}

variable "bucket_name" {
  type        = string
  description = "bucket name"
}

variable "zone" {
  type        = string
  description = "Default Zone"
  default     = "us-central1-a"
}

variable "machine_type" {
  type        = string
  description = "Default VM Type"
  default     = "e2-micro"
}