# Create ECS Autoscale Role
resource "aws_iam_role" "SEL_ecs_autoscale_role" {
    name = "${var.project_name}-ecsAutoscaleRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
        },
        "Effect": "Allow"
    }
    ]
}
EOF
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "SEL_ecs_autoscaling_policy" {
    name               = "${var.project_name}-ecs_autoscaling_policy"
    policy_type        = "TargetTrackingScaling"
    resource_id        = "service/${aws_ecs_cluster.SEL-cluster.name}/${aws_ecs_service.SEL-service.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"

    target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
        predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 75
    }

    depends_on = [aws_appautoscaling_target.SEL_ecs_asg]
}
# Attach Managed Autocaling IAM Policy to an Autoscaling IAM role
resource "aws_iam_role_policy_attachment" "sel_ecs_autoscale_role_policy_attachment" {
    role = aws_iam_role.SEL_ecs_autoscale_role.name
    policy_arn = aws_iam_policy.SEL_ecs_task_execution_policy.arn
}
