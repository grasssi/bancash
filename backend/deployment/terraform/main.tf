provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "bancash" {
  metadata {
    name = "bancash"
  }
}

resource "kubernetes_deployment" "bancash" {
  metadata {
    name = "bancash-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "bancash"
      }
    }
    template {
      metadata {
        labels = {
          App = "bancash"
        }
      }
      spec {
        container {
          name  = "bancash"
          image = "nginx:latest"
        }
      }
    }
  }
}
