# Kubernetes Service Manifest (Type: LoadBalancer)
resource "kubernetes_service_v1" "lb_service_nlb" {
  metadata {
    name = "myapp1-lb-service-nlb"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb" # To create network loadbalancer
    }
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
    }

    type = "LoadBalancer"
  }
}