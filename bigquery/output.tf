output "dataset_id_table_id" {
  value       = [google_bigquery_dataset.default.dataset_id, google_bigquery_table.default.table_id]
}