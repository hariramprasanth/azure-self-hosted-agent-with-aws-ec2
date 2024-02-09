resource "aws_vpc" "azureagent_vpc" {
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "azureagent-vpc"
  }
}

resource "aws_subnet" "azureagent_subnet" {
  vpc_id                  = aws_vpc.azureagent_vpc.id
  cidr_block              = "10.0.0.0/28"
  availability_zone_id    = "aps1-az1"
  map_public_ip_on_launch = true
  tags = {
    Name = "azureagent-subnet"
  }
}
resource "aws_internet_gateway" "azureagent_ig" {
  vpc_id = aws_vpc.azureagent_vpc.id


  tags = {
    Name = "azureagent-ig"
  }
}

resource "aws_route_table" "azureagent_route_table" {
  vpc_id = aws_vpc.azureagent_vpc.id

  tags = {
    Name = "azureagent-route-table"
  }
}

resource "aws_route_table_association" "azureagent_subnet_vpc_route_table_association" {
  subnet_id      = aws_subnet.azureagent_subnet.id
  route_table_id = aws_route_table.azureagent_route_table.id

}

resource "aws_route" "azureagent_route" {
  route_table_id         = aws_route_table.azureagent_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.azureagent_ig.id
}

