############## Domain ########################

variable "domain" {
    type = string
}
############### EC2 variables ##################

variable "ec2" {
    type = map
      default = {
        instance_type = "t2.micro",
        ami = "ami-0b8b44ec9a8f90422"
        key_name = "mykey"
      }
}



################ security groups variables #####################
variable "ingress_rules" {
    type = map
    default = {
        bastion_sg = ["ssh-tcp"],
        web_sg = ["http-80-tcp"],
        alb_sg = ["http-80-tcp","https-443-tcp"]
    }

}


############## variables declared for vpc ###############


variable "vpc_cidr"{
    type = string
    default = "192.168.0.0/16"
}

variable "vpc_subnets"{
    type = map
    default = {
        private_subnets_zones = [],
        public_subnets_zones = []
    }
}

variable "subnet_newbits"{
    type = number
    default = 8
}

###################### asg ###############
variable "asg" {
    type = object({
        availability = string
        name = string
        max_size = number
        min_size = number
        instance_type = string
        ami = string
        launch_template_name = string
        key_name = string
    })
    default = {
        availability = "public",
        name = "al-asg",
        max_size = 2,
        min_size = 1,
        instance_type = "t2.micro",
        ami = "ami-080e1f13689e07408"
        launch_template_name = "al-lt"
        key_name = "mykey"
    }
}