resource "aws_vpc" "dunnhumby_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name        = "${var.name}-vpc"
    environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dunnhumby_vpc.id
  tags = {
    name        = "${var.name}-igw"
    environment = var.environment
  }
}

resource "aws_subnet" "dunnhumby_subnet" {
  vpc_id                  = aws_vpc.dunnhumby_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    name        = "${var.name}-subnet"
    environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dunnhumby_vpc.id
  tags = {
    name        = "${var.name}-public-route-table"
    environment = var.environment
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.dunnhumby_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.dunnhumby_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  // for ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // for http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // https
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // exposing 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "${var.name}-security-group"
  }
}

