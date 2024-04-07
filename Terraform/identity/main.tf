module "iam_iam-policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.38.0"
  for_each = var.policy_mapper
  policy  = file("policies/${each.value}")
  tags = local.tags
}


module "iam_role_from_policy_file" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.38.0"
  for_each = var.policy_mapper
  role_name = each.key
  custom_role_policy_arns = [ module.iam_iam-policy[each.key].arn ]
  tags = local.tags
}


module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.38.0"
  password_reset_required = true
  create_iam_access_key = false
  password_length = 16
  for_each = toset(var.iam_users)
  name = each.value
  tags = local.tags
}

module "iam_service-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.38.0"
  create_iam_user_login_profile = false
  for_each = toset(var.service_users)
  name = each.value
  tags = local.tags

}







