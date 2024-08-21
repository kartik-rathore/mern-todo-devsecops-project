variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
  default     = "1.29"
}
variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

