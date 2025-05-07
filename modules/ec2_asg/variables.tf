variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of Public Subnet IDs"
  type        = list(string)
}

variable "aws_lb_target_group_arn" {
  description = "ALB Target Group ARN"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}
