# VPC
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr-for-main-vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "Prod-rock-VPC"
  }
}


# Public Subnet 1
resource "aws_subnet" "Test-public-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-public-subnet

  tags = {
    Name = "Test-public-sub1"
  }
}

# Public Subnet 2
resource "aws_subnet" "Test-public-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Test-public-sub2"
  }
}

# Private Subnet 1
resource "aws_subnet" "Test-priv-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-private-subnet

  tags = {
    Name = "Test-priv-sub1"
  }
}

# Private Subnet 2
resource "aws_subnet" "Test-priv-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Test-priv-sub2"
  }
}

# Public route table
resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-pub-route-table"
  }
}

# Private route table
resource "aws_route_table" "Test-priv-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-priv-route-table"
  }
}

# Public route table association 
resource "aws_route_table_association" "Public-route-table-association1"   {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

resource "aws_route_table_association" "Public-route-table-association2"   {
  subnet_id      = aws_subnet.Test-public-sub2.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

# Private route table association
resource "aws_route_table_association" "Private-route-table-association1"   {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

resource "aws_route_table_association" "Private-route-table-association2"   {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "IGW"
  }
}

 
 # Aws route
 resource "aws_route" "Public-igw-route" {
  route_table_id            = aws_route_table.Test-pub-route-table.id
  gateway_id                = aws_internet_gateway.IGW.id
  destination_cidr_block    = "0.0.0.0/0"
}

# Elastic IP
resource "aws_eip" "EIP_for_NG" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.6"
  }

# Nat Gateway for internet through the public Subnet
resource "aws_nat_gateway" "Test-Nat-gateway" {
allocation_id = aws_eip.EIP_for_NG.id
subnet_id = aws_subnet.Test-public-sub1.id


}
# Route NAT GW with private Route table
resource "aws_route" "Test-Nat-association" {
route_table_id = aws_route_table.Test-priv-route-table.id
nat_gateway_id = aws_nat_gateway.Test-Nat-gateway.id
destination_cidr_block = "0.0.0.0/0"

}
