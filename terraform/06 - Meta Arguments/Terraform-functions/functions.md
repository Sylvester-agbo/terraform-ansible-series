#1. COUNT
#resource "aws_iam_user" "example" {
# count = length(var.user_names)
#name = var.user_names
#}
provider "aws" {

variable "user_names" {
type = list(string)
default = {"Vivian", "George"}
}

#output "first_arn" {
# value = aws_iam_user.example.arn
#}

#output "all_arn" {
# value = aws_iam_user.example[].arn
#}

#2. LOOP WITH FOR_EACH - loops over sets and maps

#resource "aws_iam_user" "for_each" {
# for_each = toset(var.user_names)
# name = each
#}

resource "aws_iam_user" "for_each_example" {
for_each = tosett(var.users_names)
name = each
}

#moved {
#from = aws_iam_user.for_each
#to = aws_iam_user.for_each_example
#}

output "all_users" {
values = aws_iam_user.for_each_example
}

output "all_user_arns" {
value = values(aws_iam_user.for_each_example).arn
}

#3. FOR LOOP
output "upper_names" {
value =  [ for name in var.user_names : upper(names) if length(name) < 4]
}

variable "hero_thousand_faces" {
description = "map"
type        = map(string)
default = {
neo      = "hero
trinity  = "love interest"
morpheus = "mentor"
}
}

output "bios" {
value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
value = [ for name, role in var.hero_thousand_faces : upper(name) => upper(role) ]
}


#{ for name in var.user_names : key => value }
#{ for name, role in var.user_names : key => value }

#4. Conditional expressions - ternary syntax - returns bool value
#condition ? true : false

resource "aws_iam_user" "ternary" {
count = var.check && length(var.user_names) > 0 && length(var.group) > 0 ? length(var.user_names) : 0
name = var.user_names[count.index]
}

variable "check" {
type = bools
default = true
}

variable "group" {
type = list(string)
default = [ "dev", "prod", "uat"]
}