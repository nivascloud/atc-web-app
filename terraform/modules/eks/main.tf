resource "aws_security_group" "eks_cluster" {
  vpc_id = var.vpc_id
  name   = "${var.cluster_name}-cluster"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic (adjust as needed)
  }
}

resource "aws_security_group_rule" "allow_cluster_inbound" {
  description       = "Allow worker nodes to communicate with the cluster API"
  security_group_id = aws_security_group.eks_cluster.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks = [var.vpc_cidr] # Restrict to VPC CIDR
}


resource "aws_security_group" "worker_nodes" {
  vpc_id = var.vpc_id
  name   = "${var.cluster_name}-worker-nodes"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic (adjust as needed)
  }
}

resource "aws_security_group_rule" "allow_node_inbound" {
  description       = "Allow traffic from cluster to nodes"
  security_group_id = aws_security_group.worker_nodes.id
  type              = "ingress"
  protocol          = "-1" # all protocols
  from_port         = 0
  to_port           = 0
  cidr_blocks = ["0.0.0.0/0"] # Allow from cluster security group
}


resource "aws_security_group_rule" "allow_node_ssh" {
  description       = "Allow SSH traffic"
  security_group_id = aws_security_group.worker_nodes.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks = ["0.0.0.0/0"]  # INSECURE: Open to the world!
}

resource "aws_security_group_rule" "allow_http" {
  description       = "Allow HTTP traffic"
  security_group_id = aws_security_group.worker_nodes.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks = ["0.0.0.0/0"]  # INSECURE: Open to the world!
}

resource "aws_security_group_rule" "allow_https" {
  description       = "Allow HTTPS traffic"
  security_group_id = aws_security_group.worker_nodes.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks = ["0.0.0.0/0"] # INSECURE: Open to the world!
}
resource "aws_security_group_rule" "allow_promo" {
  description       = "Allow HTTPS traffic"
  security_group_id = aws_security_group.worker_nodes.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8000
  to_port           = 8000
  cidr_blocks = ["0.0.0.0/0"] # INSECURE: Open to the world!
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0" # Or latest 

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  cluster_security_group_id = aws_security_group.eks_cluster.id
  cluster_endpoint_private_access = false # Make cluster endpoint public
  cluster_endpoint_public_access  = true
#   node_security_group_id = [aws_security_group.worker_nodes.id]
  eks_managed_node_groups = {
    main = {
      name = "worker-group-1"
      instance_type = "t3.medium"
      desired_capacity = 2
      max_size = 3
      min_size = 1
    }
  }
}

# output "kubeconfig" {
#   value = module.eks.kubeconfig_filename
#   sensitive = true
# }