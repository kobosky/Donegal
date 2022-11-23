
#Creating 2 public subnets and 1 private subnet 

resource "aws_vpc" "kobo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "kobo"
  }
}

resource "aws_subnet" "kobo_publicsub1" {
  vpc_id     = aws_vpc.kobo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "kobo_publicsub1"
  }
}

resource "aws_subnet" "kobo_publicsub2" {
  vpc_id     = aws_vpc.kobo.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "kobo_publicsub2"
  }
}

resource "aws_subnet" "kobo_privatesub1" {
  vpc_id     = aws_vpc.kobo.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "kobo_privatesub1"
  }
}

resource "aws_route_table" "kobo_pub_route_table" {
  vpc_id = aws_vpc.kobo.id
  tags = {
    Name = "kobo_pub_route_table"
  }
}

resource "aws_route_table" "kobo_priv_route_table" {
  vpc_id = aws_vpc.kobo.id
  tags = {
    Name = "kobo_priv_route_table"
  }
}

resource "aws_route_table_association" "public_route_1_association" {
  subnet_id      = aws_subnet.kobo_publicsub1.id
  route_table_id = aws_route_table.kobo_pub_route_table.id
}

resource "aws_route_table_association" "public_route_2_association" {
  subnet_id      = aws_subnet.kobo_publicsub2.id
  route_table_id = aws_route_table.kobo_pub_route_table.id
}

resource "aws_route_table_association" "private_route_1_association" {
  subnet_id      = aws_subnet.kobo_privatesub1.id
  route_table_id = aws_route_table.kobo_priv_route_table.id
}

resource "aws_internet_gateway" "kobo_IGW" {
  vpc_id = aws_vpc.kobo.id

  tags = {
    Name = "kobo_IGW"
  }
}

resource "aws_route" "public_IGW_route" {
  route_table_id            = aws_route_table.kobo_pub_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.kobo_IGW.id
}