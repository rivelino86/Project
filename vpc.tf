resource "aws_vpc" "utc_app1" {
  cidr_block       = "172.120.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  

  tags = {
    Name       = "utc-app1"
    env        = "dev"
    team       = "wdp"
    created_by = "hyvrane"
}
}
resource "aws_internet_gateway" "dev-wdp-IGW" {
    vpc_id = aws_vpc.utc_app1.id
    tags = {
        Name = "dev-wdp-IGW"
   }
}
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.utc_app1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-wdp-IGW.id

  }
}


resource "aws_subnet" "Public_Subnet1" {
    vpc_id = aws_vpc.utc_app1.id 
    cidr_block = "172.120.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "Public_Subnet2" {
    vpc_id = aws_vpc.utc_app1.id 
    cidr_block = "172.120.2.0/24"
    availability_zone = "us-east-1b"
}

resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.utc_app1.id 
    cidr_block = "172.120.6.0/24"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.utc_app1.id 
    cidr_block = "172.120.5.0/24"
    availability_zone = "us-east-1b"
}
resource "aws_route_table_association" "Public_Subnet1_association" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.Public_Subnet1.id
  #count = 

  
}
resource "aws_route_table_association" "Public_Subnet2_association" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.Public_Subnet2.id
}