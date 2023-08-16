variable "k8s" {
  description = "k8s cluster address (get from kubectl cluster-info)"
  type = object({
    serviceHost = string
    servicePort = string
  })
  sensitive = true
}
