
variable "domain" {
    type = string
    description = "domain name, for storing the certificates in iam"
}

variable "ec2" {
    type = map
    description = "EC2 necessary variables"
      default = {
        instance_type = "t2.micro",
        ami = "ami-0b8b44ec9a8f90422"
        key_name = "mykey"
      }
}



variable "ingress_rules" {
    type = map
    description = "security groups variables"
    default = {
        bastion_sg = ["ssh-tcp"],
        web_sg = ["http-80-tcp"],
        alb_sg = ["http-80-tcp","https-443-tcp"]
    }

}




variable "vpc_cidr"{
    type = string
    default = "192.168.0.0/16"
    description = "The vpc cidr"
}

variable "vpc_subnets"{
    type = map
    description = "zones in which the subnets created"
    default = {
        private_subnets_zones = [],
        public_subnets_zones = []
    }
}

variable "subnet_newbits"{
    type = number
    description = "Variable as part of defining the subnet"
    default = 8
}

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
    description = "This object contains the necessary variables for the auto scaling group"
    default = {
        availability = "private",
        name = "al-asg",
        max_size = 2,
        min_size = 1,
        instance_type = "t2.micro",
        ami = "ami-0b8b44ec9a8f90422"
        launch_template_name = "al-lt"
        key_name = "mykey"
    }
}
