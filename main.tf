module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "ec2_asg" {
  source                  = "./modules/ec2_asg"
  vpc_id                  = module.vpc.vpc_id
  public_subnets          = module.vpc.public_subnets
  aws_lb_target_group_arn = module.alb.target_group_arn
  instance_type           = var.instance_type
  key_name                = var.key_name
}
