############## LB variables #################


variable "lb_name" {
    type = string
    description = "Loadbalancer name"
}

variable "lb_internal"{
    type = bool
    default = false
    description = "Define Loadbalancer is internal/external"
}

variable "security_groups"{
    type = list(string)
    description = "Loadbalancer security groups"
}

variable "lb_type"{
    type = string
    description = "Type of the loadbalancer"
    default = "application"
}

variable "subnets"{
    type = list(string)
    description = "Loadbalancer subnets"
}


variable "lb_enable_deletion_protection" {
    type = bool
    default = true
}


variable "lb_access_logs" {
    type =  object({
        enabled = bool
        bucket = string
        prefix = string

    })
    default = {
        enabled = false,
        bucket = "example-bucket",
        prefix = "default"
    }
}


variable "tags" {
    type = map
    default = {}
}


############## TG variables #################

# variable "target_groups" {
#     type = map(object({
#         port = number
#         protocol = string
#         type = string

#     }))
#     default = {
#         obj1 = {
#         port = 80,
#         protocol = "HTTP"
#         type = "instance"
#     }}
# }




# variable "target_group_name" {
#     type = string
# }



variable "target_group_port"{
    type = number
    default = 80 
}

variable "target_group_protocol"{
    type = string
    default = "HTTP" 
}


variable "vpc_id" {
    type = string
}

variable "target_type"{
    type = string
    default = "instance"
}


######### ALB http Listener ###################


variable "http_listener_port" {
    type = number
    default = 80
}

variable "http_listener_protocol" {
    type = string
    default = "HTTP"
}

variable "http_default_action" {
    type = string
    default = "redirect"
}


variable "http_redirect_action" {
    type = object({
        port = number
        protocol =  string
        status_code =  string
    })
    default = {
        port = 443,
        protocol = "HTTPS",
        status_code = "HTTP_301"
    }
}


######### ALB https Listener ###################


variable "https_listener_port" {
    type = number
    default = 443
}

variable "https_listener_protocol" {
    type = string
    default = "HTTPS"
}

variable "https_listener_default_action" {
    type = string
    default = "forward"
}

variable "https_listener_ssl_policy"{
    type = string
    default = "ELBSecurityPolicy-2016-08"
}


variable "certificate_arn"{
    type = string
}