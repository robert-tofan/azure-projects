# resource "kubernetes_manifest" "minimal-ingress" {
#   depends_on = [
#     data.azurerm_kubernetes_cluster.kube-cluster
#   ]
#   manifest = yamldecode(<<-EOF

# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: minimal-ingress
#   namespace: ingress-ns
#   annotations:
#     nginx.ingress.kubernetes.io/rewrite-target: /
# spec:
#   ingressClassName: nginx-example
#   rules:
#   - http:
#       paths:
#       - path: /testpath
#         pathType: Prefix
#         backend:
#           service:
#             name: test
#             port:
#               number: 80

#     EOF

#   )
# }


resource "kubernetes_manifest" "create_namespace" {
  count = var.if-manifest ? 1 : 0
  depends_on = [data.azurerm_kubernetes_cluster.kube-cluster] 
  manifest  = yamldecode(file("C:/Users/ZZ0316826/Desktop/Terraform/Terraform-full-deployment/namespace.yaml"))
}

resource "kubernetes_manifest" "create_ingress" {
  count = var.if-manifest ? 1 : 0
  depends_on = [data.azurerm_kubernetes_cluster.kube-cluster, helm_release.ingress] 
  manifest  = yamldecode(file("C:/Users/ZZ0316826/Desktop/Terraform/Terraform-full-deployment/ingress.yaml"))
}