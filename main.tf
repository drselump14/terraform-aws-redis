resource "aws_security_group" "allow_from_vpc" {
  name          = "${var.namespace}-${var.name}-${var.stage}-redis-sg"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = var.default_port
    to_port     = var.default_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow Redis Connection"
  }

}
resource "random_string" "auth_token" {
  length = 64
  special = false
}

module "redis" {
  source             = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git?ref=master"
  namespace          = var.namespace
  stage              = var.stage
  name               = "redis"
  security_groups    = [aws_security_group.allow_from_vpc.id]

  auth_token         = random_string.auth_token.result
  vpc_id             = var.vpc_id
  subnets            = var.subnets
  maintenance_window = "wed:03:00-wed:04:00"
  cluster_size       = var.cluster_size
  instance_type      = var.instance_type
  engine_version     = var.engine_version
  apply_immediately  = true
  automatic_failover = false
  availability_zones = var.availability_zones
}

output "auth_token" {
  value = random_string.auth_token.result
}
