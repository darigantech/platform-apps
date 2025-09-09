resource "kubernetes_namespace_v1" "staging" {
  metadata {
    name = "staging"
  }
}

// Use git in future for source modules
module "filebrowser" {
  source = "../../modules/filebrowser"
  app_name = var.file_browser.app_name
  container = var.file_browser.container
  deployment = var.file_browser.deployment
  service = var.file_browser.service
  volumes = var.file_browser.volumes
  namespace = var.namespace
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
  acmeCA = var.caddy.acmeCA
  caddy_helm_release = var.caddy.helm
  email  = var.CADDY_EMAIL
  ingress = var.caddy.ingress
  namespace = var.namespace
  // Generate rules from template file OR via locals loop
  rules = var.caddy.rules
}
