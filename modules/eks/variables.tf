variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}