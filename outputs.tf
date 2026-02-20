output "vpc_id" {
  description = "ID de la VPC"
  value = aws_vpc.principal.id
}

output "public_subnet_id" {
  description = "ID de la subred pública"
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID de la subred privada"
  value = aws_subnet.private.id
}

output "igw_id" {
  description = "ID del gateway de internet"
  value = aws_internet_gateway.igw.id
}