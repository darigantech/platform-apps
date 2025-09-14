variable "PRODUCTION_KUBECONFIG" {
  type = string
}

variable "CADDY_EMAIL" {
  type = string
}

variable "namespace" {
  type = string
}

variable "nginx" {
  type = object({
    app_name = string
    deployment = object({
      name = string
      replicas = number
    })
    container = object({
      name = string
      image = string
      port = number
    })
    service = object({
      name = string
      type = string
      protocol = string
      port = number
      target_port = number
    })
  })
}

variable "jellyfin" {
  type = object({
    app_name = string
    deployment = object({
      name = string
      replicas = number
    })
    container = object({
      name = string
      image = string
      port = number
    })
    service = object({
      name = string
      type = string
      protocol = string
      port = number
      target_port = number
    }),
    volumes = list(object({
      name = string
      mount_path = string
      host_path = string
    }))
  })
}

variable "ingress" {
  type = object({
    name = string
    namespace = string
    acmeCA = string
    class = string
    helm = object({
      name = string
      repository = string
      chart = string
    }),
    rules = list(object({
      host = string
      path = string
      path_type = string
      service = string
      port = number
    }))
  })
}




