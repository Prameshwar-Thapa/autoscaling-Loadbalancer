variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "List of Public Subnet CIDRs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}
