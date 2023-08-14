# create ecs cluster
resource "aws_ecs_cluster" "SEL-cluster" {
    name = "sel-cluster"
    setting {
    name  = "containerInsights" //used to collect, aggregate, and summarize metrics and logs from containerized applications and microservices
    value = "enabled"
    }
}


# create task definition
resource "aws_ecs_task_definition" "SEL-task" {
    family                   = var.ecs_task_family
    network_mode             = var.ecs_task_network_mode
    requires_compatibilities = var.ecs_task_requires_compatibilities
    task_role_arn            = aws_iam_role.SEL_ecs_task_role.arn
    cpu                      = var.ecs_task_cpu
    memory                   = var.ecs_task_memory
    container_definitions = jsonencode([
    {
      name      = "selnginx"
      image     = "public.ecr.aws/e4d8n8l9/skills-edge-lab:latest"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      
    }
  ])
}



# create ecs service
resource "aws_ecs_service" "SEL-service" {
    name             = "service"
    cluster          = aws_ecs_cluster.SEL-cluster.id
    task_definition  = aws_ecs_task_definition.SEL-task.id
    desired_count    = 4
    launch_type      = "FARGATE"
    platform_version = "LATEST"
    scheduling_strategy = "REPLICA"
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent         = 200


    network_configuration {
    assign_public_ip = true
    security_groups  = ["${aws_security_group.SEL-sg.id}"]
    subnets          = [aws_subnet.private-subnets[0].id, aws_subnet.private-subnets[1].id]
    }

    /*lifecycle {
    ignore_changes = [task_definition]
    }*/

    load_balancer {
        target_group_arn = aws_lb_target_group.SEL-http-tg.arn
        container_name = "selnginx"
        container_port = 80
    }

}
