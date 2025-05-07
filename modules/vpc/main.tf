resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "autoscaling-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}
