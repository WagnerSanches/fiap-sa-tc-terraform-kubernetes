resource "aws_security_group" "security-group-alb" {
  name        = "security-group-alb"
  vpc_id      = aws_vpc.tech-challenge.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere (for demo purposes)
  }

  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere (for demo purposes)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "ALB-Security-Group"
  }
}


resource "aws_lb" "tech-challenge" {
    name = "alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [aws_security_group.security-group-alb.id]
    
    subnets = [
        aws_subnet.public-subnet-az1.id,
        aws_subnet.public-subnet-az2.id
    ]

    tags = {
        Name = "tech-challenge"
    }
}