output "vpc_id" {
  value = aws_ssm_parameter.vpc.id
}

output "public_subnets" {
  description = "IDs das subnets publicas"

  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"

  value = [
    for subnet in aws_subnet.private : subnet.id
  ]
}

output "database_subnets" {
  description = "IDs das subnets database"

  value = [
    for subnet in aws_subnet.database : subnet.id
  ]
}