## Meta-Arguments
(https://www.terraform.io/docs/language/meta-arguments/)
- Meta-Arguments change a resource type's behavior (Example: count, for_each)

**depends_on**
- The depends_on meta-argument, if present, must be a list of references to other resources or child modules in the same calling module. Arbitrary expressions are not allowed in the depends_on argument value, because its value must be known before Terraform knows resource relationships and thus before it can safely evaluate expressions.

**Count**
- The count meta-argument accepts numeric expressions. However, unlike most arguments, the count value must be known before Terraform performs any remote resource actions. This means count can't refer to any resource attributes that aren't known until after a configuration is applied
- In blocks where count is set, an additional count object is available in expressions, so you can modify the configuration of each instance. This object has one attribute: **count.index** — The distinct index number (starting with 0) corresponding to this instance.

**for_each**
- If your instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.
- The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
- In blocks where for_each is set, an additional each object is available in expressions, so you can modify the configuration of each instance. This object has two attributes:

  each.key — The map key (or set member) corresponding to this instance.
  each.value — The map value corresponding to this instance. (If a set was provided, this is the same as each.key.)
- The for_each value must be a map or set with one element per desired resource instance. When providing a set, you must use an expression that explicitly returns a set value, like the toset function; to prevent unwanted surprises during conversion, the for_each argument does not implicitly convert lists or tuples to sets.
  -toset converts its argument to a set value. Explicit type conversions are rarely necessary in Terraform because it will convert types automatically where required. Use the explicit type conversion functions only to normalize types returned in module outputs. Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.

# map
resource "azurerm_resource_group" "rg" {
for_each = {
a_group = "eastus"
another_group = "westus2"
}
name     = each.key
location = each.value
}

# Set of strings
    resource "aws_iam_user" "the-accounts" {
      for_each = toset( ["Todd", "James", "Alice", "Dottie"] )
      name     = each.key
}

**lifecycle**





# Terraform For Loops, Lists, Maps and Count Meta-Argument

## Step-00: Pre-requisite Note
- We are using the `default vpc` in `us-west-2` region

## Step-01: Introduction
- Terraform Meta-Argument: `Count`
- **Terraform Lists & Maps**
  - List(string)
  - map(string)
- **Terraform for loops**
  - for loop with List
  - for loop with Map
  - for loop with Map Advanced
- **Splat Operators**
  - Legacy Splat Operator `.*.`
  - Generalized Splat Operator (latest)
  - Understand about Terraform Generic Splat Expression `[*]` when dealing with `count` Meta-Argument and multiple output values



## Step-02: variables.tf - Lists and Maps
```t
# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t3.micro", "t3.small"]
}


# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa"  = "t3.small"
    "prod" = "t3.large"
  }
}
```

## Step-04: ec2securitygroups.tf and ami-datasource.tf
- No changes to both files

## Step-05: ec2instance.tf
```t
# How to reference List values ?
instance_type = var.instance_type_list[1]

# How to reference Map values ?
instance_type = var.instance_type_map["prod"]

# Meta-Argument Count
count = 2

# count.index
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
```

## Step-06: outputs.tf
- for loop with List
- for loop with Map
- for loop with Map Advanced
```t

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.myec2vm[*].public_dns
}
```

## Step-07: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
Observations:
1) play with Lists and Maps for instance_type

# Terraform Apply
terraform apply -auto-approve
Observations:
1) Two EC2 Instances (Count = 2) of a Resource myec2vm will be created
2) Count.index will start from 0 and end with 1 for VM Names
3) Review outputs in detail (for loop with list, maps, maps advanced, splat legacy and splat latest)
```

## Step-08: Terraform Comments
- Single Line Comments - `#` and `//`
- Multi-line Commnets - `Start with /*` and `end with */`
- We are going to comment the legacy splat operator, which might be decommissioned in future versions
```t
# Output Legacy Splat Operator (latest) - Returns the List
/* output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  */
```

## Step-09: Clean-Up
```t
# Terraform Destroy
terraform destroy -auto-approve

# Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
