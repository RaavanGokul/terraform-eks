variable "region" {
    type = string
    default = "ap-south-1"
    description = "AWS region to deploy resources"
}
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR block for the VPC"
}

variable "dns_support" {
    type = bool
    default = true
    description = "Enable DNS support for the VPC"
}

variable "dns_hostnames" {
    type = bool
    default = true
    description = "Enable DNS hostnames for the VPC"
}

variable "common_tags" {
    type = map(string)
    default = {
        environment = "development"
        company  = "gk"
        Owner = "DevOps Team"
        ManagedBy = "Terraform"
    }
    description = "Common tags to apply to all resources"
}
variable "environment" {
    type = string
    default = "dev"
    description = "Environment name for tagging resources"
}
variable "project_name" {
    type = string
    default = "gk-eks"
    description = "Project name for tagging resources"
}
variable "cluster_name" {
    type = string
    default = "first-cluster"
    description = "Name of the EKS cluster"
}
variable "public_subnet_cidr" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    description = "CIDR block for the public subnet"
}

variable "public_subnet_azs" {
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b"]
    description = "Availability zones for the public subnets"
}

variable "private_subnet_cidr" {
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24"]
    description = "CIDR block for the private subnet"
}

variable "private_subnet_azs" {
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b"]
    description = "Availability zones for the private subnets"
}

variable "igw_name" {
    type = string
    default = "eks_igw"
    description = "Name of the Internet Gateway"
}

variable "create_nat" {
    type = bool
    default = true
    description = "Flag to create NAT Gateway"
}

variable "nat_gateway_name" {
    type = string
    default = "eks_nat_gw"
    description = "Name of the NAT Gateway"
}

variable "eks_cluster_role_name" {
    type = string
    default = "eks_cluster_role"
    description = "Name of the IAM role for EKS cluster"
}

variable "eks_node_group_role_name" {
    type = string
    default = "eks_node_group_role"
    description = "Name of the IAM role for EKS node group"
}
variable "kubernetes_version" {
    type = string
    default = "1.34"
    description = "Kubernetes version for the EKS cluster"
}
variable "eks_cluster_policy_arns" {
    type = list(string)
    default = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    ]
    description = "List of IAM policy ARNs for the EKS cluster role"
}
variable "node_group_name" {
    type = string
    default =  "dev-eks-node-group"
    description = "Name of the EKS node group"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "Instance type for the EKS node group"
}

variable "key_name" {
    type = string
    default = "terraform-key"
    description = "Name of the SSH key pair for EC2 instances"
}

variable "node_policy_arns" {
    type = list(string)
    default = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
}
variable "node_disk_size" {
    type = number
    default = 20
    description = "Disk size (in GB) for the EKS node group instances"
}
variable "node_group_desired_size" {
    type = number
    default = 2
    description = "Desired size of the EKS node group"
}
variable "node_group_max_size" {
    type = number
    default = 3
    description = "Maximum size of the EKS node group"
}
variable "node_group_min_size" {
    type = number
    default = 1   
    description = "Minimum size of the EKS node group"
}
variable "max_unavailable_nodes" {
    type = string
    default = 2
}
variable "max_unavailable_nodes_percentage" {
    type = string
    default = 50
}

