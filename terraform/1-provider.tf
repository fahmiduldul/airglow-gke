provider "google" {
  project = "fahmi-a"
  region  = "asia-southeast2"
}

terraform {
  required_version = ">= 1.4.0"

  backend "gcs" {
    bucket = "terraform-state-519731740241"
    prefix = "airflow"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.61"
    }
  }
}
