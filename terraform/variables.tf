variable "grafana_url" {
  description = "Grafana Cloud stack URL"
  type        = string
  default     = "https://tobsirl.grafana.net/"
}

variable "grafana_stack_id" {
  description = "Grafana Cloud stack (instance) ID"
  type        = number
  default     = 483657
}

variable "grafana_service_account_token" {
  description = "Grafana service account token (Admin role). Set via TF_VAR_grafana_service_account_token."
  type        = string
  sensitive   = true
}

variable "github_app_id" {
  description = "GitHub App ID (from the app's About section)"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App installation ID (from github.com/settings/installations/<id>)"
  type        = string
}

variable "github_app_private_key_path" {
  description = "Path to the GitHub App private key .pem file. Keep it outside the repo."
  type        = string
}

variable "github_repo_url" {
  description = "Repository Git Sync reads and writes"
  type        = string
  default     = "https://github.com/tobsirl/grafana-git-sync"
}
