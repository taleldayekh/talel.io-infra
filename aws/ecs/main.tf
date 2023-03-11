module "vpc" {
  source = "../vpc"
}

module "iam" {
  source = "../iam"
}

resource "aws_key_pair" "talelio_key_pair" {
  key_name   = "talelio-key"
  public_key = file("~/.ssh/aws-talelio-key.pub")
}

resource "aws_launch_template" "launch_template" {
  image_id               = "ami-05e7fa5a3b6085a75"
  instance_type          = "t2.micro"
  # vpc_security_group_ids = [module.vpc.public_security_group_id]
  key_name               = aws_key_pair.talelio_key_pair.id 
 
  # TODO: Move to dedicated script file
  user_data = filebase64("cluster.sh")

  iam_instance_profile {
    name = module.iam.instance_profile_name
  }

  network_interfaces {
    security_groups = [module.vpc.public_security_group_id]
    associate_public_ip_address = true
    subnet_id = module.vpc.public_subnet_id
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = "talelio-asg"
  vpc_zone_identifier = [module.vpc.public_subnet_id]
  desired_capacity    = 1
  min_size            = 1
  max_size            = 2
  health_check_type   = "EC2"

  launch_template {
    id = aws_launch_template.launch_template.id
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "talelio-cluster"
}

# ?: Should there be one task def per container? AWS do allow for multiple
# ?: containers to be defined in a task definition, but what happens if we
# ?: only want to update one of those containers?

resource "aws_ecs_task_definition" "task_definition" {
  family       = "talelio"
  network_mode = "bridge"

  # TODO: Replace image wiht ECR image
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:1.23.3-alpine"
      cpu       = 10
      memory    = 256
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

resource "aws_ecs_service" "service" {
  name            = "talelio"
  cluster         = "talelio-cluster"
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
}
