# Get List of Availability Zones in a Spefific Region
# Region is set in c1-versions.tf in Provider Block
# Datasource-1
data "aws_availability_zones" "my_azones" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Check if that respective Instance Type is supported in list of available 
# Get the List of Availability Zones in a Particular region where that respective Instance Type
# Datasource-2
data "aws_ec2_instance_type_offerings" "my_ins_type" {
    for_each = toset(data.aws_availability_zones.my_azones.names)
    filter {
        name = "instance-type"
        values = ["t3.micro"]
    }

    filter {
      name = "location"
      values = [each.key]
    }

    location_type = "availability-zone"
}

# Output
# Important Note: Once for_each is set, its attributes must be accessed on specific instance
output "output_v2_1" {
#   value = "${data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types}"
    value = toset([for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types])
}

# Output 
# Create a Map with key as availability zone and value as Instance Type supported
output "output_v2_2" {
  value = tomap({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
  })
}
