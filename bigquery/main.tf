data "google_project" "project" {
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = var.dataset_id
  friendly_name               = "source_dataset_test"
  description                 = "Source Dataset of TEST"
  location                    = var.source_location

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = var.table_id
  deletion_protection = false

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
    [
    {
        "name": "permalink",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "The Permalink"
    },
    {
        "name": "state",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "State where the head office is located"
    }
    ]
    EOF

}

resource "google_bigquery_dataset" "my_destination_dataset" {

  dataset_id    = "Destination_dataset_Test"
  friendly_name = "Dest Dataset"
  description   = "Destination Dataset"
  location      = var.destination_location
}

resource "google_bigquery_data_transfer_config" "cross_region_copy" {
    service_account_name = var.bigquery_service_account

    display_name = "Test Data Transfer Config"
    location = var.destination_location
  
    data_source_id         = "cross_region_copy"
    destination_dataset_id = google_bigquery_dataset.my_destination_dataset.dataset_id
    params = {
        # destination_table_name_template = "destination_table"
        # write_disposition               = "WRITE_TRUNCATE"
        # query                           = "SELECT * FROM sales_data"
        source_dataset_id = google_bigquery_dataset.default.dataset_id
        overwrite_destination_table = true
        source_project_id = data.google_project.project.project_id

    }
  
    schedule = "every 24 hours"
}