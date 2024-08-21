variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}
variable "public_subnets" {
  description = "CIDR for the public subnet"
  type        = list(string)
}
variable "instance_type" {
  description = "type for the EC2 instance"
  type        = string
} 