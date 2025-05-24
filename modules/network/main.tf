#create VPC
# after VPC created, a main route table created to route traffic within vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "attach vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Project VPC IG"
  }
}

# create second route table
resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "2nd route table"
  }
}

# associate public subnet with second route table
resource "aws_route_table_association" "public_subnet_associate" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(var.public_subnet_cidrs, count.index)
  route_table_id = aws_route_table.second_rt.id
}




output "vpc_id" {
  value = aws_vpc.main.id
}


output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}