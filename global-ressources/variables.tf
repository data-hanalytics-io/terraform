variable "project_id" {
  type        = string
  description = "ID of the Google Project"  
}

variable "location" {
  type        = string
  description = "Default Region"
  default     = "US"
}

variable "bucket_name" {
  type        = string
  description = "bucket name"
}