# vpc
resource "aws_vpc" "proj1_vpc" {
  cidr_block       = "192.168.0.0/16"

  tags = {
    Name = "proj1_vpc"
  }
}

# Subnets
resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.proj1_vpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pub_sub1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.proj1_vpc.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pub_sub2"
  }
}

resource "aws_subnet" "priv_sub1" {
  vpc_id     = aws_vpc.proj1_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "priv_sub1"
  }
}

resource "aws_subnet" "priv_sub2" {
  vpc_id     = aws_vpc.proj1_vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "priv_sub2"
  }
}