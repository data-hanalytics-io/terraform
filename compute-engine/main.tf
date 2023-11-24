# [START compute_hanalytics_quickstart_vm]
resource "random_id" "rnd" {
  byte_length = 4
}

# [START compute_regional_external_vm_address]
resource "google_compute_address" "default" {
  name   = "static-ip-address"
  region = var.region
}
# [END compute_regional_external_vm_address]

# Create a single Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  name         = "hanalytics-instance"
  machine_type = var.machine_type
  zone = var.zone
  tags         = ["ssh", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = file("startup.sh")

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.default.address
    }
  }
}
# [END compute_hanalytics_quickstart_vm]

resource "google_compute_network" "vpc_network" {
  name                    = "hanalytics-network"
  auto_create_subnetworks = "true"
}

# [START vpc_hanalytics_quickstart_ssh_fw]
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
# [END vpc_hanalytics_quickstart_ssh_fw]
 
# [START vpc_hanalytics_quickstart_ports_fw]
resource "google_compute_firewall" "app-firewall" {
  name    = "hanalytics-app-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = [ "80","5000","8080","8000"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-health-check"]
}
# [END vpc_hanalytics_quickstart_ports_fw]

/* resource "google_compute_health_check" "default" {
  name               = "http-basic-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  http_health_check {
    port               = 80
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
  timeout_sec         = 5
  unhealthy_threshold = 2
}

resource "google_compute_backend_service" "default" {
  name                            = "web-backend-service"
  connection_draining_timeout_sec = 0
  health_checks                   = [google_compute_health_check.default.id]
  load_balancing_scheme           = "EXTERNAL"
  port_name                       = "http"
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
} */
# to create a DNS zone
resource "google_dns_managed_zone" "default" {
  name          = "example-zone-googlecloudexample"
  dns_name      = "my-test-${random_id.rnd.hex}.io."
  description   = "Example DNS zone"
  force_destroy = "true"
}

# to register web-server's ip address in DNS
resource "google_dns_record_set" "default" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "A"
  ttl          = 300
  rrdatas = [
    google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  ]
}