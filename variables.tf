variable "region" {
  description = "Región de AWS"
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Bloque CIDR para las subredes públicas"
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Bloque CIDR para las subredes privadas"
  type = string
  default = "10.0.2.0/24"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type = string
  default = "t3.micro"
}
