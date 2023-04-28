# Kubernetes Service Manifest (Type: NodePort Service)
resource "kubernetes_service_v1" "np_service" {
  metadata {
    name = "myapp1-nodeport-service"
  }

  spec {
    selector = {
      # Referencing the kubernetest deployment selector label
      app = "${kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app}" # here 0 is for the nested block first item
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
      node_port   = 30001
    }

    type = "NodePort"
  }
}