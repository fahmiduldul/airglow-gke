resource "google_compute_subnetwork" "private" {
  name          = "private"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.airflow_vpc.id
  region        = "asia-southeast2"

  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name = "k8s-pod-range",
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name = "k8s-service-range",
      ip_cidr_range = "10.2.0.0/16"
    }
  ]
}