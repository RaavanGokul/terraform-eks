environment = "dev"
vpc_cidr = "10.0.0.0/16"
common_tags ={
    environment = "dev"
    company = "lic"
    Owner = "CloudInfra-Team"
    ManagedBy = "terraform"
}
public_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
igw_name = "dev-lic-igw"
create_nat = true
nat_gateway_name = "dev-lic-nat"
kubernetes_version = "1.34"
eks_cluster_role_name = "lic_eks_cluster_role"
eks_node_group_role_name = "lic_eks_node_group_role"
node_group_name = "eks-dev-ng"
instance_type = "t2.micro"
node_disk_size = 20
node_group_desired_size = 2
node_group_max_size = 4
node_group_min_size = 1
max_unavailable_nodes_percentage = "50"
cluster_name = "lic-cluster"
project_name = "play"

