# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "SEL_ecs_asg" {
    max_capacity       = var.autoscaling_max_size
    min_capacity       = var.autoscaling_min_size
    resource_id        = "service/${aws_ecs_cluster.SEL-cluster.name}/${aws_ecs_service.SEL-service.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
    role_arn = aws_iam_role.SEL_ecs_autoscale_role.arn
}

