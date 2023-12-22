resource "google_storage_bucket" "default" {
  name          = var.bucket_name
  force_destroy = false
  location      = var.location
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}