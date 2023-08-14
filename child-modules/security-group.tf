# Create Dynamic security group 
resource "aws_security_group" "SEL-sg" {
    name        = var.project_name
    description = "enable https and http access on port 443 and 80"
    vpc_id      = aws_vpc.SEL-vpc.id

    dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
    from_port = port.value
    to_port = port.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
}

    dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
    from_port = port.value
    to_port = port.value
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

tags   = {
    Name = "${var.project_name}-sg"
    environment = var.environment
} 
}


# Create Dynamic security group for RDS postgres
resource "aws_security_group" "SEL-rds-sg" {
    name        = "${var.project_name}-rds-sg"
    description = "enable rds access on port 5432"
    vpc_id      = aws_vpc.SEL-vpc.id

    dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules_rds
    content {
    from_port = port.value
    to_port = port.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
}

    dynamic "egress" {
    iterator = port
    for_each = var.egressrules_rds
    content {
    from_port = port.value
    to_port = port.value
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

tags   = {
    Name = "${var.project_name}-rds-sg"
    environment = var.environment
} 
}