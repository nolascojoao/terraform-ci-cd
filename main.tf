provider "aws" {
  region = "us-east-1"

  # Configuração para autenticação via OIDC, usando a variável de ambiente para o ARN da role
  assume_role {
    role_arn     = var.aws_role_arn
    session_name = "github-actions"
  }
}

# Obtém a única VPC disponível na conta
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vpc-01"]
  }
}

# Obtém a subnet específica pela tag
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-01"]
  }
  vpc_id = data.aws_vpc.selected.id
}

# Criação de um grupo de segurança básico
resource "aws_security_group" "basic" {
  name        = "basic-sg"
  description = "Basic security group"
  vpc_id      = data.aws_vpc.selected.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criação da instância EC2
resource "aws_instance" "example" {
  ami                   = "ami-04b4f1a9cf54c11d0"
  instance_type         = "t2.micro"
  subnet_id             = data.aws_subnet.selected.id
  vpc_security_group_ids = [aws_security_group.basic.id]

  tags = {
    Name = "ExampleInstance"
  }
}
