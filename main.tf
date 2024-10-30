# Terraform Configuration
provider "aws" {
  region = "us-east-1"
}

# Create a security group for the ALB
resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg-"
  vpc_id      = "vpc-03d80d9498c782450"  # Replace with your VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the ALB
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["subnet-0457ee46e0e354f0b", "subnet-02f307e8020091259"] # Replace with your Subnet IDs

  enable_deletion_protection = false
}

# Create a target group for the ALB
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-03d80d9498c782450"  # Replace with your VPC ID

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# Create an Auto Scaling Launch Template
resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-lt-"
  image_id      = "ami-06b21ccaeff8cd686"  # Replace with your AMI ID
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  // Optionally specify other parameters as needed
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"  # Use the latest version of the launch template
  }

  min_size            = 1
  max_size            = 5
  desired_capacity    = 2
  vpc_zone_identifier = ["subnet-0457ee46e0e354f0b", "subnet-02f307e8020091259"]  # Replace with your Subnet IDs

  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true
  }

  # Attach the ASG to the target group
  health_check_type = "ELB"
  health_check_grace_period = 300
  depends_on = [aws_lb.app_lb]
}

# Attach the ASG to the target group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  lb_target_group_arn    = aws_lb_target_group.app_tg.arn
}

# Outputs
output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}
ading main.tf…]()
