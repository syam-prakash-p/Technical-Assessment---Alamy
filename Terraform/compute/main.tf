resource "aws_iam_server_certificate" "ssl-certificate" {
  name_prefix      = var.domain
  certificate_body = file("certificates/server.crt")
  private_key      = file("certificates/server.key")

  lifecycle {
    create_before_destroy = true
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"
  manage_default_security_group = false
  cidr = var.vpc_cidr
  azs = setunion(var.vpc_subnets.private_subnets_zones,var.vpc_subnets.public_subnets_zones)
  public_subnets = [ for zone in var.vpc_subnets.public_subnets_zones : cidrsubnet(var.vpc_cidr, var.subnet_newbits, index(var.vpc_subnets.public_subnets_zones,zone)+1)]
  private_subnets = [ for zone in var.vpc_subnets.private_subnets_zones : cidrsubnet(var.vpc_cidr, var.subnet_newbits, length(var.vpc_subnets.public_subnets_zones)+index(var.vpc_subnets.public_subnets_zones,zone)+1)]
  tags = local.tags
}


module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"
  for_each  = var.ingress_rules
  name = each.key
  ingress_rules = each.value
  egress_rules = [ "all-all" ]
  description = "Custom security group created by terrafrom"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  vpc_id = module.vpc.vpc_id
  tags = local.tags

  }


module "ec2-instance-bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"
  ami = var.ec2.ami
  instance_type  = var.ec2.instance_type
  associate_public_ip_address = true
  key_name = var.ec2.key_name
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security-group["bastion_sg"].security_group_id]
  tags = local.tags

}




module "alb" {
  source = "./modules/alb"
    lb_name = "my-alb"
    security_groups = [module.security-group["alb_sg"].security_group_id]
    subnets = module.vpc.public_subnets
    vpc_id = module.vpc.vpc_id
    certificate_arn = aws_iam_server_certificate.ssl-certificate.arn
    tags = local.tags
    # target_group_arn = module.alb.target_group.arn

}


module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.1"
  name = var.asg.name
  vpc_zone_identifier = var.asg.availability == "public"  ? module.vpc.public_subnets : module.vpc.private_subnets
  max_size = var.asg.max_size
  min_size = var.asg.min_size
  image_id = var.asg.ami
  key_name = var.asg.key_name
  security_groups = [module.security-group["web_sg"].security_group_id]
  user_data = base64encode(file("user-data/setup-nginx.sh"))
  instance_name	= "web-server"
  launch_template_name = var.asg.launch_template_name
  instance_type = var.asg.instance_type
  launch_template_version = "$Latest"
  target_group_arns	= [ module.alb.target_group.arn ]
  tags = local.tags

}

