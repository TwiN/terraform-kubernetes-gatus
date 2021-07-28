output "kubernetes_service_name" {
  value = kubernetes_service.gatus.metadata[0].name
}

output "kubernetes_service_port" {
  value = kubernetes_service.gatus.spec[0].port
}
