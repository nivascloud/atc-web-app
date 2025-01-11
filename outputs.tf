# Output the EKS cluster endpoint
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
# output "kubeconfig" {
#   value     = module.eks.kubeconfig
#   sensitive = true
# }