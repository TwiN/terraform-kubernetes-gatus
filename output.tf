output "kubernetes_service_name" {
  value = kubernetes_service_v1.gatus.metadata[0].name
}

output "kubernetes_service_port" {
  value = kubernetes_service_v1.gatus.spec[0].port[0].port
}
