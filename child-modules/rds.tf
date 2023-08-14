# Create Database Subnet Group

resource "aws_db_subnet_group" "seldbsg" {
    name       = "${var.project_name}-dbsg"
    subnet_ids = [aws_subnet.private-subnets[0].id, aws_subnet.private-subnets[1].id]

    tags = {
    Name = "${var.project_name}-dbsg"
    environment = var.environment
    }
}

# Create RDS
resource "aws_db_instance" "myrdspostres" {
    allocated_storage      = var.allocated_storage
    engine                 = var.engine
    engine_version         = var.engine_version
    instance_class         = var.instance_class
    db_name                = var.db_name
    username               = var.username
    password               = var.password
    parameter_group_name   = var.parameter_group_name
    skip_final_snapshot    = var.skip_final_snapshot
    vpc_security_group_ids = ["${aws_security_group.SEL-rds-sg.id}"]
    db_subnet_group_name   = "${aws_db_subnet_group.seldbsg.name}"

}