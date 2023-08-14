# Create Application Load Balancer
resource "aws_lb" "SEL-lb" {
    name               = "SEL-lb"
    internal           = var.internal
    load_balancer_type = var.load_balancer_type
    security_groups    = ["${aws_security_group.SEL-sg.id}"]
    subnets            = [aws_subnet.public-subnets[0].id, aws_subnet.public-subnets[1].id]

    enable_deletion_protection = var.enable_deletion_protection

    # access_logs {
    # bucket  = aws_s3_bucket.lb_logs.id
    # prefix  = "test-lb"
    # enabled = true
    # }

    tags = {
    environment = var.environment
    }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "SEL-alb-http-listener" {
    load_balancer_arn  = aws_lb.SEL-lb.arn
    port              = var.lb-http-listener-port
    protocol          = var.lb-http-listener-protocol

    default_action {
    type = var.lb-http-listener-type

    redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
    }

    }
}

/*# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "sel-certificate" {
    domain      = "skillsedgelab.com"
    types       = ["AMAZON_ISSUED"]
    most_recent = true
}*/

# create a listener on port 443 with forward action
resource "aws_lb_listener" "SEL-alb-https-listener" {
    load_balancer_arn = aws_lb.SEL-lb.arn
    port              = var.lb-https-listener-port
    protocol          = var.lb-https-listener-protocol
    certificate_arn = aws_acm_certificate.sel-certificate.arn
    ssl_policy         = "ELBSecurityPolicy-TLS13-1-2-2021-06"

    default_action {
    type             = var.lb-https-listener-type
    target_group_arn = aws_lb_target_group.SEL-http-tg.arn
    }
}


# create target group
resource "aws_lb_target_group" "SEL-http-tg" {
    name       = "SEL-tg"
    port       = var.lb_target_group_port
    protocol   = var.lb_target_group_protocol
    vpc_id     = aws_vpc.SEL-vpc.id
    target_type = var.lb_target_group_target_type


    health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 5
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 3
    }

    lifecycle {
    create_before_destroy = true
    }
}
