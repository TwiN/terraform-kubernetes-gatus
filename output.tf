output "kubernetes_service_name" {
  value = kubernetes_service.gatus.metadata[0].name
}
