terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.PRODUCTION_KUBECONFIG
}

provider "helm" {
  kubernetes {
    config_path = var.PRODUCTION_KUBECONFIG
  }
}