resource "aws_instance" "proj1_bastion" {
  ami           = "ami-0182f373e66f89c85"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub_sub1.id
  security_groups = [ aws_security_group.proj1_bastion_sc.id ]
  associate_public_ip_address = true

  tags = {
    Name = "proj1_bastion_server"
  }
}