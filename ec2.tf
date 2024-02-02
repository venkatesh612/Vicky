# data "aws_iam_policy_document" "ec2" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_policy" "session-manager" {
#   description = "session-manager"
#   name        = "session-manager"
#   policy      = jsonencode({
#     "Version":"2012-10-17",
#     "Statement":[
#       {
#         "Action": "*",
#         "Effect": "Allow",
#         "Resource": "*"
#       }
#       # },
#       # {
#       #   "Action": "ssm:*",
#       #   "Effect": "Allow",
#       #   "Resource": "*"
#       # }
#     ]
#   })
# }

# resource "aws_iam_role" "session-manager-role" {
#   assume_role_policy = data.aws_iam_policy_document.ec2.json
#   name               = "session-manager-role"
#   tags = {
#     Name = "session-manager-role"
#   }
# }

# resource "aws_iam_instance_profile" "session-manager-instance" {
#   name  = "session-manager-instance"
#   role  = aws_iam_role.session-manager-role.name
# }

resource "aws_instance" "my_instance" {
  ami             = "ami-0005e0cfe09cc9050" 
  instance_type   = "t2.micro"
  key_name        = "Mag" 
  #iam_instance_profile        = aws_iam_instance_profile.session-manager-instance.id
  security_groups = [aws_security_group.my_security_group.id]
  subnet_id = aws_subnet.main-sub.id

  tags = {
    Name = "Magtech"
  }
}