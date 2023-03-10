module "vpc" {
  source = "../vpc"
}

module "iam" {
  source = "../iam"
}

resource "aws_launch_template" "launch_template" {
  image_id               = "ami-05e7fa5a3b6085a75"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.public_security_group_id]

  # TODO: Move to dedicated script file
  user_data = filebase64("cluster.sh")

  iam_instance_profile {
    name = module.iam.instance_profile_name
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
