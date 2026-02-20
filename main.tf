# ----------------- VPC ------------------
resource "aws_vpc" "principal" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc-principal"
  }
}

# ----------------- Subredes -----------------
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.principal.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-publica"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.principal.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "subnet-privada"
  }
}

# ---------------- INTERNET GATEWAY ------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.principal.id
  tags = {
    Name = "igw"
  }
}

# ---------------- ROUTE TABLE ------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.principal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rtb-publica"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ---------------- SECURITY GROUP -----------------
resource "aws_security_group" "sg_principal" {
  vpc_id = aws_vpc.principal.id
  name = "sg_principal"
  description = "Security group principal"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_principal"
  }
}

# ----------------- AMI (Amazon Linux 2023) -----------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023*x86_64"]
  }


  filter {
      name = "virtualization-type"
      values = ["hvm"]
  }
}

# -----------------Instancia EC2 ---------------------
resource "aws_instance" "instancia" {
  ami = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private.id
  security_groups = [aws_security_group.sg_principal.id]
  tags = {
    Name = "instancia-ec2"
  }
}
