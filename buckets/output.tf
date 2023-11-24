output "external_bucket_name" {
  value       = google_storage_bucket.hanalytics_external_bucket.name
}
output "internal_bucket_names" {
  value       = [ for bucket_name in google_storage_bucket.hanalytics_bucket: bucket_name.name]
}