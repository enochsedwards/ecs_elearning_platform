output "vpc_id" {
    value = aws_vpc.SEL-vpc.id
}

output "vpc_cidr" {
    value = aws_vpc.SEL-vpc.cidr_block
}

output "public-subnets_id" {
    value = aws_subnet.public-subnets[*]
}



output "private-subnets_id" {
    value = aws_subnet.private-subnets[*]
}


output "security-group_id" {
    value = aws_security_group.SEL-sg.id
}