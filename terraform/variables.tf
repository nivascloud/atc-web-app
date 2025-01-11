variable "aws_region" {
  type    = string
  default = "us-east-1" # Set your default region
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.24" # or latest supported version
}