# provider
provider "aws" {
  region = var.region
}

# infrastructure models for SEL project

module "SEL-elearning-project" {
  source                            = "../child-modules"
  region                            = var.region
  project_name                      = var.project_name
  vpc_cidr                          = var.vpc_cidr
  instance_tenancy                  = var.instance_tenancy
  enable_dns_hostnames              = var.enable_dns_hostnames
  enable_dns_support                = var.enable_dns_support
  public_cidrs                      = var.public_cidrs
  private_cidrs                     = var.private_cidrs
  availability_zone                 = var.availability_zone
  map_public_ip_on_launch           = var.map_public_ip_on_launch
  SEL-rt                            = var.SEL-rt
  role                              = var.role
  ingressrules                      = var.ingressrules
  egressrules                       = var.egressrules
  ingressrules_rds                  = var.ingressrules_rds
  egressrules_rds                   = var.egressrules_rds
  subnet_ids                        = var.subnet_ids
  allocated_storage                 = var.allocated_storage
  engine                            = var.engine
  engine_version                    = var.engine_version
  instance_class                    = var.instance_class
  db_name                           = var.db_name
  username                          = var.username
  password                          = var.password
  parameter_group_name              = var.parameter_group_name
  skip_final_snapshot               = var.skip_final_snapshot
  db_subnet_group_name              = var.db_subnet_group_name
  internal                          = var.internal
  load_balancer_type                = var.load_balancer_type
  enable_deletion_protection        = var.enable_deletion_protection
  environment                       = var.environment
  lb-http-listener-port             = var.lb-http-listener-port
  lb-http-listener-protocol         = var.lb-http-listener-protocol
  lb-http-listener-type             = var.lb-http-listener-type
  lb-https-listener-port            = var.lb-https-listener-port
  lb-https-listener-protocol        = var.lb-https-listener-protocol
  lb-https-listener-type            = var.lb-https-listener-type
  lb_target_group_port              = var.lb_target_group_port
  lb_target_group_protocol          = var.lb_target_group_protocol
  autoscaling_min_size              = var.autoscaling_min_size
  autoscaling_max_size              = var.autoscaling_max_size
  autoscaling_health_check_type     = var.autoscaling_health_check_type
  autoscaling_instance_type         = var.autoscaling_instance_type
  ecs_task_family                   = var.ecs_task_family
  ecs_task_network_mode             = var.ecs_task_network_mode
  ecs_task_requires_compatibilities = var.ecs_task_requires_compatibilities
  ecs_task_cpu                      = var.ecs_task_cpu
  ecs_task_memory                   = var.ecs_task_memory
  ecs_service_desired_count         = var.ecs_service_desired_count
  ecs_service_launch_type           = var.ecs_service_launch_type
  ecs_service_platform_version      = var.ecs_service_platform_version
  lb_target_group_target_type       = var.lb_target_group_target_type
  domain_name                       = var.domain_name
  alternative_name                  = var.alternative_name

}
