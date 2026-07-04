environment = "prod"
vpc_cidr = "172.0.0.0/16"
common_tags ={
    environment = "prod"
    company = "lic"
    Owner = "CloudInfra-Team"
    ManagedBy = "terraform"
}
public_subnet_cidr = ["172.0.32.0/24", "172.0.64.0/24"]
private_subnet_cidr = ["172.0.96.0/24", "172.0.128.0/24"]
igw_name = "prod-lic-igw"
create_nat = true
nat_gateway_name = "prod-lic-nat"
kubernetes_version = "1.34"
eks_cluster_role_name = "prod_lic_eks_cluster_role"
eks_node_group_role_name = "prod_lic_eks_node_group_role"
node_group_name = "eks-prod-ng"
instance_type = "t3.micro"
node_disk_size = 20
node_group_desired_size = 10
node_group_max_size = 15
node_group_min_size = 5
max_unavailable_nodes_percentage = 30
cluster_name = "prod_lic-cluster"
project_name = "play"

