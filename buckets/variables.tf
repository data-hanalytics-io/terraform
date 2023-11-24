variable "project_id" {
  type        = string
  description = "ID of the Google Project"  
}

variable "location" {
  type        = string
  description = "Default Location"
  default     = "EU"
}

variable "internet_bucket_name" {
  type        = string
  description = "name of the bucket name exposed to Internet"
}

variable "set_of_bucket_name" {
  type        = list(string)
  description = "A set of internal GCS bucket names"
}