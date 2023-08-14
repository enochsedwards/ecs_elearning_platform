region                            = "us-west-1"
project_name                      = "sel-e-learning"
vpc_cidr                          = "10.0.0.0/16"
instance_tenancy                  = "default"
enable_dns_hostnames              = true
enable_dns_support                = true
map_public_ip_on_launch           = true
public_cidrs                      = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs                     = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone                 = ["us-west-1a", "us-west-1b"]
subnet_ids                        = ["private-subnet-1", "private-subnet-2"]
SEL-rt                            = ["SEL-publicrt", "SEL-privatert"]
role                              = "SEL-ec2-rds-role"
ingressrules                      = [80, 443]
egressrules                       = [0]
ingressrules_rds                  = [5432]
egressrules_rds                   = [0]
allocated_storage                 = "20"
engine                            = "postgres"
engine_version                    = "15.3"
instance_class                    = "db.t4g.large"
db_name                           = "seldb01"
username                          = "Kaffadu"
password                          = "password"
parameter_group_name              = "default.postgres15"
skip_final_snapshot               = true
db_subnet_group_name              = "dbsg"
internal                          = false
load_balancer_type                = "application"
enable_deletion_protection        = false
environment                       = "Production"
lb-http-listener-port             = "80"
lb-http-listener-protocol         = "HTTP"
lb-http-listener-type             = "redirect"
lb-https-listener-port            = "443"
lb-https-listener-protocol        = "HTTPS"
lb-https-listener-type            = "forward"
lb_target_group_port              = "80"
lb_target_group_protocol          = "HTTP"
lb_target_group_target_type       = "ip"
autoscaling_min_size              = 1
autoscaling_max_size              = 4
autoscaling_health_check_type     = "EC2"
autoscaling_instance_type         = "t3.micro"
ecs_task_family                   = "service"
ecs_task_network_mode             = "awsvpc"
ecs_task_requires_compatibilities = ["FARGATE"]
ecs_task_cpu                      = 2048
ecs_task_memory                   = 4096
ecs_service_desired_count         = 1
ecs_service_launch_type           = "FARGATE"
ecs_service_platform_version      = "LATEST"
domain_name                       = "skillsedgelab.com"
alternative_name                  = ["*.skillsedgelab.com"]
