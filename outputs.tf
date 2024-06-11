output "instance_public_ip_us_east_1" {
  value = module.ec2_us_east_1.instance_public_ip
}

output "instance_public_ip_us_east_2" {
  value = module.ec2_us_east_2.instance_public_ip
}