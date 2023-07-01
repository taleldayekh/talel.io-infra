resource "aws_iam_role" "ec2_role" {
  name               = "talelio-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    Name = "talelio-ec2-role"
  }
}
