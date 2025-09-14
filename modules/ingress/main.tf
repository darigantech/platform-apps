resource "helm_release" "caddy_ingress_controller" {
  name       = var.ingress.helm.name
  repository = var.ingress.helm.repository
  chart      = var.ingress.helm.chart
  namespace  = var.ingress.namespace
  atomic = true

  set {
    name  = "ingressController.config.acmeCA"
    value = var.ingress.acmeCA
  }

  set {
    name  = "ingressController.config.email"
    value = var.email
  }
}

resource "kubernetes_ingress_v1" "caddy_ingress" {
  metadata {
        name = var.ingress.name
        annotations = {
          "kubernetes.io/ingress.class" : var.ingress.class
        }
        namespace = var.ingress.namespace
      }

  spec {
    ingress_class_name = var.ingress.class

    dynamic "rule" {
      for_each = var.ingress.rules
      content {
        host = rule.value.host
        http {
          path {
            path = rule.value.path
            path_type = rule.value.path_type
            backend {
              service {
                name = rule.value.service
                port {
                  number = rule.value.port
                }
              }
            }
          }
        }
      }
    }
  }
}

# resource "helm_release" "caddy_ingress_controller" {
#   name       = var.caddy_helm_release.name
#   repository = var.caddy_helm_release.repository
#   chart      = var.caddy_helm_release.chart
#   namespace  = var.namespace
#
#   set {
#     name  = "ingressController.config.acmeCA"
#     value = var.acmeCA
#   }
#   set {
#     name = "ingressController.config.email"
#     value = var.email
#   }
# }
#
# resource "kubernetes_ingress_v1" "caddy_ingress" {
#   metadata {
#     name = var.ingress.name
#     annotations = {
#       "kubernetes.io/ingress.class" : var.ingress.class
#     }
#     namespace = var.namespace
#   }
#   wait_for_load_balancer = true
#
#   spec {
#     ingress_class_name = var.ingress.class
#
#     dynamic "rule" {
#       for_each = var.rules
#       content {
#         host = rule.value.host
#         http {
#           path {
#             path = rule.value.path
#             path_type = rule.value.path_type
#             backend {
#               service {
#                 name = rule.value.service
#                 port {
#                   number = rule.value.port
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }