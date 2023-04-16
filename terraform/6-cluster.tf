locals {
  enable_gke = true
}

resource "google_container_cluster" "airflow" {
  count = local.enable_gke ? 1 : 0

  name               = "airflow"
  location           = "asia-southeast2"
  initial_node_count = 1
  enable_autopilot   = true
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  networking_mode = "VPC_NATIVE"
  network         = google_compute_network.airflow_vpc.self_link
  subnetwork      = google_compute_subnetwork.private.self_link

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
