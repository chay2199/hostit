// backend/main.tf

resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend-${var.environment}"
  }
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name      = "backend-${var.environment}"
    namespace = kubernetes_namespace.backend.metadata.0.name
  }

  spec {
    replicas = var.backend_replicas

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = "your-backend-image"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name      = "backend-${var.environment}"
    namespace = kubernetes_namespace.backend.metadata.0.name
  }

  spec {
    selector = {
      app = "backend"
    }

    # ClusterIP type makes the service private
    type = "ClusterIP"

    port {
      port        = 8080
      target_port = 8080
    }
  }
}

output "backend_url" {
  value = kubernetes_service.backend.metadata.0.name
}
