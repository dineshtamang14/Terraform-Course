# Terraform Output Values

# Output - For Loop with List
output "for_output_list" {
   description = "for loop with list"
   value = [for instance in aws_instance.myec2vm: instance.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "for loop with map"
  value = {           
   for instance in aws_instance.myec2vm: instance.id => instance.public_dns
  }
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "for loop with map - Advanced"
  value = {           
     for c, instance in aws_instance.myec2vm: c => instance.public_dns
  }
}

# Output Legacy Splat Operator (Legacy) - Returns the List
output "legacy_splat_instance_publicdns" {
   description = "Legacy Splat Operator (Deprecated)"
   value = aws_instance.myec2vm.*.public_dns
}

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
   description = "Generalized latest Splate Operator "
   value = aws_instance.myec2vm[*].public_dns
}