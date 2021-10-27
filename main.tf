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

