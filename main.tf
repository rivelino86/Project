resource "aws_instance" "server2" {
  ami = "ami-06a0cd9728546d178"
  instance_type = "t2.micro"
  key_name = "utc-key"
  #security_groups = [ "${aws_security_group.web2_sg.name}"]
  vpc_security_group_ids = [ aws_security_group.web2_sg.id ]
  subnet_id = "${aws_subnet.Public_Subnet1.id}"
  #associate_public_ip_address = true
  user_data = file("install.sh")
   tags = {
        Name = "utc-dev-inst"
        Team = "Cloud-Transformation"
        Environment = "Dev"
        Created-by = "Rivelino"
      }
      root_block_device {
        volume_size = 20 
      volume_type = "gp3"
      }
}