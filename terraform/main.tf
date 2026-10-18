terraform {
  required_version = ">= 1.11" # write-only secrets used by Git Sync resources

  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 4.49.0, < 5.0.0"
    }
  }

  # Local state is fine for this personal sandbox.
  # terraform.tfstate is git-ignored; never commit it.
}

# Git Sync resources are App Platform resources: use url + auth + stack_id,
# not the Grafana Cloud API settings (cloud_api_url / cloud_access_policy_token).
provider "grafana" {
  url      = var.grafana_url
  auth     = var.grafana_service_account_token
  stack_id = var.grafana_stack_id
}
