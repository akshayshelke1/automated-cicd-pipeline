  module "eks" {
    source          = "terraform-aws-modules/eks/aws"
    cluster_name    = "advanced-eks-cluster"
    cluster_version = "1.24"
    vpc_id          = aws_vpc.main_vpc.id
    subnets         = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

    node_groups = {
      eks_nodes = {
        desired_capacity = 3
        max_capacity     = 5
        min_capacity     = 2

        instance_type = "t3.medium"
        key_name      = "your-key-pair"
        tags = {
          Name = "advanced-eks-node"
        }
      }
    }
  }