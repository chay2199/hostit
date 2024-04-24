// frontend/main.tf

resource "kubernetes_namespace" "frontend" {
  metadata {
    name = "frontend-${var.environment}"
  }
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend-${var.environment}"
    namespace = kubernetes_namespace.frontend.metadata.0.name
  }

  spec {
    replicas = var.frontend_replicas

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "your-frontend-image"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name      = "frontend-${var.environment}"
    namespace = kubernetes_namespace.frontend.metadata.0.name
  }

  spec {
    selector = {
      app = "frontend"
    }

    # LoadBalancer type exposes the service publicly via a load balancer
    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}

output "frontend_url" {
  value = kubernetes_service.frontend.status.0.load_balancer.0.ingress.0.hostname
}
