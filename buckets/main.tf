resource "google_storage_bucket" "hanalytics_bucket" {
  for_each      = toset(var.set_of_bucket_name)
  name          = each.value
  force_destroy = false
  location      = var.location
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention = "enforced"
}

// default bucket with internet exposition
resource "google_storage_bucket" "hanalytics_external_bucket" {
  name          = var.internet_bucket_name
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}


resource "google_storage_bucket_iam_member" "member" {
  bucket   = google_storage_bucket.hanalytics_external_bucket.name
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}