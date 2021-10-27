#deploy a Kubernetes
resource "digitalocean_kubernetes_cluster" "focus" {
  name    = "focus"
  region  = "nyc1"
  version = "1.21.5-do.0"

  tags = ["my-tag"]

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = false
    node_count = 1
    tags       = ["node-pool-tag"]
  }

}

resource "kubernetes_pod" "test" {
  metadata {
    name = "test-focus"
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "test-focus"

      env {
        name  = "environment"
        value = "Prod"
      }
      
      port {
        container_port = 8080
      }

      liveness_probe {
        http_get {
          path = "/nginx_status"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["focus.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}

