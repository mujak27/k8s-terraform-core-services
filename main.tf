terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}


module "cni" {
  source = "./modules/cni"
  k8s = {
    serviceHost = var.k8s.serviceHost
    servicePort = var.k8s.servicePort
  }
}

module "csi" {
  depends_on = [module.cni]
  source     = "./modules/csi"
}
