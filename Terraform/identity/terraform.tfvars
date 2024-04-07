#### sample varialbes (example)

### For creating iam users
iam_users = [
  "jose" ,
  "mark" 
]

## for creating  service users
service_users = [
  "tux"
]

## policy mapper for roles
policy_mapper = {
    ec2TestRole = "ec2-fullaccess.json",
    lambdaTestrole = "lambda.json"
}

