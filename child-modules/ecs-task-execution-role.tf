# create an iam role for ecs task
resource "aws_iam_role" "SEL_ecs_task_role" {
    name = "SEL-ecs-task-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
EOF
}

# create iam policy document
resource "aws_iam_policy" "SEL_ecs_task_execution_policy" {
    name = "${var.project_name}-SELecsTaskExecutionRole"

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Action   = [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
                ]
        Effect   = "Allow"
        Resource = "*"
        },
    ]
    })
}

# attach ecs task execution policy to the iam role
resource "aws_iam_role_policy_attachment" "SEL_ecs_task_role_policy_attachment" {
    role       = aws_iam_role.SEL_ecs_task_role.name
    policy_arn = aws_iam_policy.SEL_ecs_task_execution_policy.arn
}