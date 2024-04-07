variable "iam_users"{
    type = list
    description = "List of iam users and policies"
}

variable "service_users"{
    type = list
    description = "list of services users and poicies"
}


variable "policy_mapper" {
    type = map
    description = "role specific poclicies can be mapped in this varialbe"
}

