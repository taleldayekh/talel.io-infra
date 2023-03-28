resource "aws_eip" "eip" {
  tags = {
    Name = "talelio-eip"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "talelio-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "talelio-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "talelio-igw"
  }
}

resource "aws_route_table" "public_rt" {
  // Associates route table with VPC
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "talelio-public-rt"
  }
}

// Associates route table with public subnet
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "talelio-public-sg"
  }
}
