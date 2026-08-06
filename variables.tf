variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR principal da VPC"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs adicionais da VPC"
  default     = []
}

variable "public_subnets" {
  description = "Lista de subnets publicas da VPC"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Lista de subnets privadas da VPC"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
}

variable "database_subnets" {
  description = "Lista de subnets privadas da VPC"
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
  default = []
}