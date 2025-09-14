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

variable "email" {
  type = string
}