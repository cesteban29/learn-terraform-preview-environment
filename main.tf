terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "hashicorp-training"
    workspaces {
      tags = ["hashicupsBackend"]
    }
  }

  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "0.0.1-alpha"
    }
  }
}

variable "is_prod" {
  description = "If false, deploys preview environment EC2 and LB"
  default     = false
}

variable "vercel_project" {
  description = "Vercel project ID"
  default     = "prj_"
}

module "backend" {
  source  = "./backend-terraform"

  vercel_project = var.vercel_project
  is_prod = var.is_prod
}

output "lb_dns_name" {
    value = module.backend.lb_dns_name
}

output "preview_url" {
    value = module.backend.preview_url
} 