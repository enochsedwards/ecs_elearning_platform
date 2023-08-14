# Create VPC
resource "aws_vpc" "SEL-vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames

    tags = {
    Name = "${var.project_name}-vpc"
    environment = var.environment
    }
}

# Create Subnets : public
resource "aws_subnet" "public-subnets" {
    count                                       = length(var.public_cidrs)
    vpc_id                                      = aws_vpc.SEL-vpc.id
    cidr_block                                  = var.public_cidrs[count.index]
    availability_zone                           = var.availability_zone[count.index]
    map_public_ip_on_launch                     = var.map_public_ip_on_launch

    tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
    environment = var.environment
    }
}

# Create Subnets : Private
resource "aws_subnet" "private-subnets" {
    count             = length(var.private_cidrs)
    vpc_id            = aws_vpc.SEL-vpc.id
    cidr_block        = var.private_cidrs[count.index]
    availability_zone = var.availability_zone[count.index]

    tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
    environment = var.environment
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "SEL-igw" {
    vpc_id = aws_vpc.SEL-vpc.id

    tags = {
    Name = "${var.project_name}-igw"
    environment = var.environment
    }
}

# elastic ip address
resource "aws_eip" "SEL-eip" {
    domain = "vpc"

    tags = {
    Name = "${var.project_name}-Elastic IP"
    environment = var.environment
    }
}

# NAT gateway components
resource "aws_nat_gateway" "SEL-ngw" {
    allocation_id = aws_eip.SEL-eip.id
    subnet_id     = aws_subnet.public-subnets[0].id

    tags = {
        Name = "${var.project_name}-nat-gateway"
        environment = var.environment
}
}

# Create Private Route table: attach NAT Gateway 
resource "aws_route_table" "SEL-private-rt" {
    vpc_id = aws_vpc.SEL-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.SEL-ngw.id
    }

    tags = {
    Name = "${var.project_name}-private-rt"
    environment = var.environment
    }
}

# Create Public Route table: attach Internet Gateway 
resource "aws_route_table" "SEL-public-rt" {
    vpc_id = aws_vpc.SEL-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SEL-igw.id
    }

    tags = {
    Name = "${var.project_name}-public-rt"
    environment = var.environment
    }
}



# Public Route table association with public subnets
resource "aws_route_table_association" "SEL-public-rt-association" {
    count          = length(var.public_cidrs)
    subnet_id     = aws_subnet.public-subnets[count.index].id
    route_table_id = aws_route_table.SEL-public-rt.id
}

# Private Route table association with private subnets
resource "aws_route_table_association" "SEL-private-rt-association" {
    count          = length(var.private_cidrs)
    subnet_id     = aws_subnet.private-subnets[count.index].id
    route_table_id = aws_route_table.SEL-private-rt.id
}