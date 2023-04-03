module "vpc" {
  source = "../vpc"
}

module "iam" {
  source = "../iam"
}

resource "aws_key_pair" "key_pair" {
  public_key = file(var.aws_public_key_path)
}

resource "aws_instance" "ec2_instance" {
  #! Has to be an ECS compatible Amazon Machine Image
  ami                  = "ami-05e7fa5a3b6085a75"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.key_pair.id
  user_data            = filebase64("talelio-ec2-setup.sh")
  security_groups      = [module.vpc.public_security_group_id]
  subnet_id            = module.vpc.public_subnet_id
  iam_instance_profile = module.iam.ec2_instance_profile

  tags = {
    Name = "talelio-ec2-instance"
  }
}

resource "aws_eip_association" "talelio_ec2_eip_association" {
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = module.vpc.public_elastic_ip
}

resource "aws_ecs_cluster" "cluster" {
  name = "talelio-cluster"
}

resource "aws_ecs_task_definition" "persistent_storage" {
  family       = "talelio-persistent-storage"
  network_mode = "bridge"

  container_definitions = jsonencode([
    {
      name      = "talelio-redis"
      image     = "redis:7.0.10-alpine"
      essential = true
      portMappings = [
        {
          containerPort = 6379
          hostPort      = 6379
        }
      ]
    }
  ])
}
