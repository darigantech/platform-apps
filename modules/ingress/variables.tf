variable "ingress" {
  type = object({
    name = string
    class = string
  })
}

variable "namespace" {
  type = string
}

variable "rules" {
  type = list(object({
    host = string
    path = string
    path_type = string
    service = string
    port = number
  }))
}

variable "caddy_helm_release" {
  type = object({
    name = string
    repository = string
    chart = string
  })
}

variable "acmeCA" {
  type = string
}

variable "email" {
  type = string
}