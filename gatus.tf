resource "kubernetes_config_map" "gatus" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  data = {
    "config.yaml" = var.configuration_file_content
  }
}

resource "kubernetes_deployment" "gatus" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = {
      app = var.name
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.name
      }
    }
    template {
      metadata {
        name      = var.name
        namespace = var.namespace
        labels = {
          app = var.name
        }
        annotations = {
          // Used to automatically trigger restart on config change
          config_hash = sha1(jsonencode(kubernetes_config_map.gatus.data))
        }
      }
      spec {
        container {
          name              = var.name
          image             = var.image
          image_pull_policy = "IfNotPresent"
          port {
            name           = "http"
            container_port = 8080
          }
          resources {
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
          dynamic "env" {
            for_each = var.environment_variables
            content {
              name  = env.key
              value = env.value
            }
          }
          readiness_probe {
            http_get {
              path = "/health"
              port = "8080"
            }
            initial_delay_seconds = 2
            period_seconds        = 8
            failure_threshold     = 1
            success_threshold     = 1
            timeout_seconds       = 2
          }
          liveness_probe {
            http_get {
              path = "/health"
              port = "8080"
            }
            initial_delay_seconds = 2
            period_seconds        = 8
            failure_threshold     = 3
            success_threshold     = 1
            timeout_seconds       = 2
          }
          volume_mount {
            mount_path = "/config"
            name       = "${var.name}-config"
          }
        }
        volume {
          name = "${var.name}-config"
          config_map {
            name = kubernetes_config_map.gatus.metadata[0].name
          }
        }
        node_selector = var.node_selector
      }
    }
  }
}

resource "kubernetes_service" "gatus" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  spec {
    port {
      protocol = "TCP"
      name     = "http"
      port     = 8080
    }
    selector = {
      app = var.name
    }
  }
}

resource "kubernetes_ingress" "gatus" {
  count = var.ingress_host != "" ? 1 : 0
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = var.ingress_annotations
  }
  spec {
    backend {
      service_name = var.name
      service_port = 8080
    }
    rule {
      host = var.ingress_host
      http {
        path {
          backend {
            service_name = var.name
            service_port = 8080
          }
          path = "/"
        }
      }
    }
    dynamic "tls" {
      for_each = var.ingress_tls_secret_name == "" ? [] : [1]
      content {
        secret_name = var.ingress_tls_secret_name
        hosts = [var.ingress_host]
      }
    }
  }
}
