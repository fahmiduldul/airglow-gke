resource "google_compute_router" "airflow_vpc_router" {
  name    = "airflow-vpc-router"
  region  = "asia-southeast2"
  network = google_compute_network.airflow_vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  nat_ip_allocate_option             = "AUTO_ONLY"
  router                             = google_compute_router.airflow_vpc_router.name
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
