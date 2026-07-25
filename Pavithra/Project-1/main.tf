resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.project_name}-public_subnet"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public_subnet_2"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet
  availability_zone = var.availability_zone

  tags = {
    Name        = "${var.project_name}-private_subnet"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_subnet.id
}

resource "aws_security_group" "web_sg" {
  name_prefix = "${var.project_name}-web_sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.project_name}-web_sg"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "${var.project_name}-db_sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.project_name}-db-sg"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = file("${path.module}/web-server-key.pub")

  tags = {
    Name        = "${var.project_name}-keypair"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_eip" "web_server" {
  domain = "vpc"

  tags = {
    Name        = "${var.project_name}-web_server"
    Environment = var.Environment
    Owner       = var.owner
  }
}


resource "aws_eip_association" "web_eip_association" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.web_server.id
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  tags = {
    Name        = "${var.project_name}-web_server"
    Environment = var.Environment
    Owner       = var.owner
  }
}

resource "aws_instance" "db_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet.id
  security_groups             = [aws_security_group.db_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = false
  tags = {
    Name        = "${var.project_name}-db_server"
    Environment = var.Environment
    Owner       = var.owner
  }
}







resource "aws_instance" "web_server_2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_2.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Name        = "${var.project_name}-web_server_2"
    Environment = var.Environment
    Owner       = var.owner
  }
}