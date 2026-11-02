output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_ids" {
  description = "IDs das subnets publicas"

  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "private_subnets_ids" {
  description = "IDs das subnets privadas"

  value = [
    for index, subnet in aws_subnet.private :
    subnet.id
    if strcontains(var.private_subnets[index].name, "-private-")
  ]
}

output "pod_subnets_ids" {
  description = "IDs das subnets destinadas aos Pods"

  value = [
    for index, subnet in aws_subnet.private :
    subnet.id
    if strcontains(var.private_subnets[index].name, "-pods-")
  ]
}

output "database_subnets_ids" {
  description = "IDs das subnets database"

  value = [
    for subnet in aws_subnet.database : subnet.id
  ]
}