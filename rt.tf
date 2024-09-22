# Internet Gateway
resource "aws_internet_gateway" "proj1_igw" {
  vpc_id = aws_vpc.proj1_vpc.id

  tags = {
    Name = "proj1_igw"
  }
}

# Nat Gateway
resource "aws_eip" "proj1_nat_eip" {
  tags = {
    Name = "proj1_nat_eip"
  }
}

resource "aws_nat_gateway" "proj1_ngw" {
  allocation_id = aws_eip.proj1_nat_eip.id
  subnet_id     = aws_subnet.pub_sub2.id

  tags = {
    Name = "proj1_ngw"
  }
}

# Route Tables
resource "aws_route_table" "proj1_pub_rt" {
  vpc_id = aws_vpc.proj1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proj1_igw.id
  }

  tags = {
    Name = "proj1_pub_rt"
  }
}

resource "aws_route_table" "proj1_priv_rt" {
  vpc_id = aws_vpc.proj1_vpc.id

  tags = {
    Name = "proj1_priv_rt"
  }
}

resource "aws_route" "priv_route" {                             // Update Private Route Table to Route Traffic Through NAT Gateway!
  route_table_id         = aws_route_table.proj1_priv_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.proj1_ngw.id
}

# Route Table Association
resource "aws_route_table_association" "proj1_pub_rta1" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.proj1_pub_rt.id
}

resource "aws_route_table_association" "proj1_pub_rta2" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.proj1_pub_rt.id
}

resource "aws_route_table_association" "proj1_priv_rta1" {
  subnet_id      = aws_subnet.priv_sub1.id
  route_table_id = aws_route_table.proj1_priv_rt.id
}

resource "aws_route_table_association" "proj1_priv_rta2" {
  subnet_id      = aws_subnet.priv_sub2.id
  route_table_id = aws_route_table.proj1_priv_rt.id
}