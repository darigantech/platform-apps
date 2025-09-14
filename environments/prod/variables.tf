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

# variable "ingress" {
#   type = object({
#     namespace = string
#     rules = list(object({
#       host = string
#       path = string
#       path_type = string
#       service = string
#       port = number
#     }))
#   })
# }


# ingress = {
#   namespace = "production"
#   rules = [{
#     host = "web.darigan.tech"
#     path = "/"
#     path_type = "Prefix"
#     service = "nginx-service"
#     port = 8082
#   }]
# }

# resource "helm_release" "caddy_ingress_controller" {
#   name       = "caddy-ingress-controller"
#   repository = "https://caddy-ingress-controller.github.io/caddy-ingress"
#   chart      = "caddy-ingress-controller"
#   namespace  = "kube-system" # A common namespace for system services
#   create_namespace = true
#   atomic = true
# }
#
# variable "caddy_helm_release" {
#   type = object({
#     name = string
#     repository = string
#     chart = string
#   })
# }

# variable ingress {
#   rules =
# }


