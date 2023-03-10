data "aws_iam_policy_document" "ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "talelio-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2.json

  tags = {
    Name = "talelio-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "talelio-instance-profile"
  role = aws_iam_role.ec2.name
}
