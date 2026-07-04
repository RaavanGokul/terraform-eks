 resource "aws_vpc" "eks_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = var.dns_support
    enable_dns_hostnames = var.dns_hostnames
    tags = merge({"Name" = "eks_vpc"}, var.common_tags)
}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = element(var.public_subnet_azs, count.index)
    map_public_ip_on_launch = true
    tags = merge({"Name" = "eks_public_subnet-${var.public_subnet_azs[count.index]}"}, var.common_tags)
}

resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = element(var.private_subnet_cidr, count.index)
    availability_zone = element(var.private_subnet_azs, count.index)
    map_public_ip_on_launch = false
    tags = merge({"Name" = "eks_private_subnet-${var.private_subnet_azs[count.index]}"}, var.common_tags)
}   

resource "aws_internet_gateway" "eks_igw" {
    vpc_id = aws_vpc.eks_vpc.id
    tags = merge({"Name" = var.igw_name}, var.common_tags)
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = merge({"Name" = "eks_nat_eip"}, var.common_tags)
    depends_on = [ aws_internet_gateway.eks_igw ]
}

resource "aws_nat_gateway" "eks_nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnets[1].id
    tags = merge({"Name" = "eks_nat_gw"}, var.common_tags)
    depends_on = [ aws_internet_gateway.eks_igw ]
}
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_igw.id

    }
    tags = merge({"Name" = "eks_public_rt"}, var.common_tags)
}

resource "aws_route_table_association" "public_rt_assoc" {
    count = length(aws_subnet.public_subnets)
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.eks_nat_gw.id
    }
    tags = merge({"Name" = "eks_private_rt"}, var.common_tags)
}

resource "aws_route_table_association" "private_rt_assoc" {
    count = length(aws_subnet.private_subnets)
    subnet_id = aws_subnet.private_subnets[count.index].id
    route_table_id = aws_route_table.private_rt.id
}



