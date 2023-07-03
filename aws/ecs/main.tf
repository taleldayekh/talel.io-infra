module "iam" {
  source = "../iam"
}

resource "aws_key_pair" "key_pair" {
  public_key = file(var.ec2_public_key_path)
}

resource "aws_instance" "ec2_instance" {
  #! AMI has to be an ECS compatible Amazon Machine Image
  ami                  = "ami-05e7fa5a3b6085a75"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.key_pair.id
  user_data            = filebase64("talelio-ec2-setup.sh")
  security_groups      = [""]
  subnet_id            = ""
  iam_instance_profile = module.iam.ec2_instance_profile

  tags = {
    Name = "talelio-ec2-instance"
  }
}

resource "aws_eip_association" "talelio_ec2_eip_association" {
  instance_id   = ""
  allocation_id = ""
}

resource "aws_ecs_cluster" "cluster" {
  name = "talelio-cluster"
}

resource "aws_ecs_task_definition" "persistent_storage" {
  family       = "talelio-persistent-storage"
  network_mode = "bridge"

  volume {
    name      = "postgresql"
    host_path = "/var/lib/talelio-postgresql"
  }

  container_definitions = jsonencode([
    {
      name      = "talelio-redis"
      image     = "redis:7.0.11-alpine"
      memory    = 128
      essential = true
      portMappings = [
        {
          containerPort = 6379
          hostPort      = 6379
        }
      ]
    },
    {
      name = "talelio-postgresql"
      # TODO: Retrieve image URI from ECR
      image     = ""
      memory    = 384
      essential = true
      portMappings = [
        {
          containerPort = 5432
          hostPort      = 5432
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "postgresql"
          containerPath = "/var/lib/postgresql/data"
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "reverse_proxy" {
  family       = "talelio-reverse-proxy"
  network_mode = "bridge"

  container_definitions = jsonencode([
    {
      name      = "talelio-nginx"
      image     = "nginx:1.25.1-alpine"
      memory    = 128
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "persistent_storage_service" {
  name            = "talelio-persistent-storage"
  cluster         = "talelio-cluster"
  task_definition = aws_ecs_task_definition.persistent_storage.arn
  desired_count   = 1
}

resource "aws_ecs_service" "reverse_proxy_service" {
  name            = "talelio-reverse-proxy"
  cluster         = "talelio-cluster"
  task_definition = aws_ecs_task_definition.reverse_proxy.arn
  desired_count   = 1
}
