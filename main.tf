provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# CNI - Ingress
resource "kubernetes_config_map" "bgp_config_map" {
  metadata {
    name = "bgp-config"
    namespace = "kube-system"
  }

  data = {
    "config.yaml" = "${file("${path.module}/bgp-config.yaml")}"
  }
}

resource "helm_release" "cilium" {
  depends_on = [ kubernetes_config_map.bgp_config_map ]

  name       = "cilium"
  namespace = "kube-system"
  version = "1.14.0"

  repository = "https://helm.cilium.io"
  chart      = "cilium"
  create_namespace = true

  set {
    name  = "bgp.enabled"
    value = true
  }

  set {
    name  = "bgp.announce.podCIDR"
    value = true
  }

  set {
    name  = "bgp.announce.loadbalancerIP"
    value = true
  }

  set {
    name = "ingressController.enabled"
    value = true
  }

  set {
    name = "ingressController.loadbalancerMode"
    value = "dedicated"
  }

  set {
    name = "kubeProxyReplacement"
    value = "strict"
  }

  set {
    name = "k8sServiceHost"
    value = var.k8s.serviceHost
  }

  set {
    name = "k8sServicePort"
    value = var.k8s.servicePort
  }
}

# CSI
resource "helm_release" "longhorn" {
  depends_on = [ helm_release.cilium ]
  name = "longhorn"

  repository = "https://charts.longhorn.io"
  chart = "longhorn"
  namespace = "longhorn-system"
  create_namespace = true
}