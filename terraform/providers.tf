terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.0"
    # }
  }
}
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks_token.token
  }
}

provider "aws" {
  region = var.aws_region
}