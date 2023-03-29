resource "aws_iam_role" "ec2_role" {
  name               = "talelio-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    Name = "talelio-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "talelio-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
