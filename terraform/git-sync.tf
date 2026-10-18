# GitHub App credentials Grafana uses to talk to GitHub.
resource "grafana_apps_provisioning_connection_v0alpha1" "github_app" {
  metadata {
    uid = "tobsirl-github-app"
  }

  spec {
    title       = "tobsirl GitHub App"
    description = "GitHub App connection for Git Sync"
    type        = "github"
    url         = "https://github.com"

    github {
      app_id          = var.github_app_id
      installation_id = var.github_app_installation_id
    }
  }

  # Write-only: sent to Grafana, never stored in Terraform state.
  secure {
    private_key = {
      create = filebase64(pathexpand(var.github_app_private_key_path))
    }
  }
  secure_version = 1 # bump to re-send the key, e.g. after rotating it
}

# Which repo, branch and folder Git Sync keeps in sync.
resource "grafana_apps_provisioning_repository_v0alpha1" "dashboards" {
  depends_on = [grafana_apps_provisioning_connection_v0alpha1.github_app]

  metadata {
    uid = "tobsirl-grafana-git-sync"
  }

  spec {
    title       = "grafana-git-sync"
    description = "Dashboards synced from tobsirl/grafana-git-sync"
    type        = "github"

    # "write" = commit straight to main, "branch" = save to a branch and open a PR.
    # For work, consider ["branch"] only, with branch protection on main.
    workflows = ["write", "branch"]

    sync {
      enabled          = true
      target           = "folder" # creates a Grafana folder for this repo
      interval_seconds = 60
    }

    github {
      url    = var.github_repo_url
      branch = "main"
      path   = "dashboards" # only this folder is synced; terraform/ is ignored
    }

    connection {
      name = grafana_apps_provisioning_connection_v0alpha1.github_app.metadata.uid
    }
  }
}
