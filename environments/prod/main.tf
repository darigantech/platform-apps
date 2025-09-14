resource "kubernetes_namespace_v1" "production" {
  metadata {
    name = var.namespace
  }
}

module "nginx" {
  source = "../../modules/nginx"
  app_name = var.nginx.app_name
  container = var.nginx.container
  deployment = var.nginx.deployment
  service = var.nginx.service
  namespace = var.namespace
}

module "ingress" {
  source = "../../modules/ingress"
  ingress = var.ingress
  email = var.CADDY_EMAIL
}