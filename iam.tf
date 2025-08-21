resource "aws_iam_user" "iam-users" {
  for_each = toset(local.users)

  name = each.value
}

locals {
  users = ["User-1", "User-2", "User-3"]
}

# Attach S3 ReadOnly Policy
resource "aws_iam_user_policy_attachment" "s3_readonly" {
  for_each = toset(local.users)

  user       = aws_iam_user.iam-users[each.value].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Attach EC2 ReadOnly Policy
resource "aws_iam_user_policy_attachment" "ec2_readonly" {
  for_each = toset(local.iam-users)

  user       = aws_iam_user.iam-users[each.value].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


