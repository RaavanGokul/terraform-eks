resource "aws_eks_cluster" "main" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks_cluster_role.arn
    version = var.kubernetes_version

    vpc_config {
        subnet_ids = flatten([aws_subnet.public_subnets[*].id,aws_subnet.private_subnets[*].id])
        endpoint_private_access = true
        endpoint_public_access = true
    }

    enabled_cluster_log_types = [
        "api",
        "audit",
        "authenticator",
        "controllerManager",
        "scheduler"
    ]
    access_config {
        authentication_mode = "API_AND_CONFIG_MAP"
        bootstrap_cluster_creator_admin_permissions = true
    }
  tags = merge({"Name" = "${local.nameprefix}"}, var.common_tags)
   
   depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_policy,
        aws_iam_role_policy_attachment.eks_cluster_policy
    ]
}

resource "aws_iam_role" "eks_cluster_role" {
    name = var.eks_cluster_role_name
    assume_role_policy = data.aws_iam_policy_document.eks_cluster_role.json
    tags = merge({"Name" = var.eks_cluster_role_name}, var.common_tags)
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    role = aws_iam_role.eks_cluster_role.name
    for_each = toset(var.eks_cluster_policy_arns)
    policy_arn = each.value
    
}

resource "aws_eks_node_group" "main" {
    cluster_name = aws_eks_cluster.main.id
    node_group_name = var.node_group_name
    node_role_arn = aws_iam_role.eks_node_group_role.arn
    subnet_ids = aws_subnet.private_subnets[*].id
    capacity_type = "ON_DEMAND"
    instance_types = [var.instance_type]
    disk_size = var.node_disk_size
    ami_type = "AL2023_x86_64_STANDARD"
    scaling_config {
        desired_size = var.node_group_desired_size
        max_size = var.node_group_max_size
        min_size = var.node_group_min_size
    }
    update_config {
        #max_unavailable = var.max_unavailable_nodes
        max_unavailable_percentage = var.max_unavailable_nodes_percentage
    }
    tags = merge({"Name" = "${local.nameprefix}"}, var.common_tags)
    depends_on = [
        aws_iam_role_policy_attachment.eks_node_policys
    ]
}

resource "aws_iam_role" "eks_node_group_role" {
    name = var.eks_node_group_role_name
    assume_role_policy = data.aws_iam_policy_document.eks_node_group_role.json
    tags = merge({"Name" = var.eks_node_group_role_name}, var.common_tags)
}

resource "aws_iam_role_policy_attachment" "eks_node_policys" {
    role = aws_iam_role.eks_node_group_role.name
    for_each = toset(var.node_policy_arns)
    policy_arn = each.value
  
}

