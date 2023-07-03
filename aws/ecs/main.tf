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

resource "aws_ecs_cluster" "cluster" {
  name = "talelio-cluster"
}
