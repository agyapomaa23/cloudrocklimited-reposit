# First EC2 
resource "aws_instance" "Test-server1" {
ami = "ami-0be590cb7a2969726" # eu-west-2
instance_type = var.Instance-Type
key_name = "Jirakp"
vpc_security_group_ids =[aws_security_group.Test-sec-group.id]
associate_public_ip_address = true
subnet_id = aws_subnet.Test-public-sub1.id

tags = {
name = "Test-server1"
}
}

# Second EC2 
resource "aws_instance" "Test-server2" {
ami = "ami-0be590cb7a2969726" # eu-west-2
instance_type = var.Instance-Type
key_name = "Jirakp"
vpc_security_group_ids =[aws_security_group.Test-sec-group.id]
associate_public_ip_address = true
subnet_id = aws_subnet.Test-public-sub2.id

tags = {
name = "Test-server2"
}
}