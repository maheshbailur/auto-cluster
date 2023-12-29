locals {
  terra_data = jsondecode(file("./final-terra-out.json"))
}


resource "aws_instance" "bastion_host" {
  ami                    = "ami-0430580de6244e02e"
  instance_type          = "t2.micro"
  subnet_id              = local.terra_data.public_subnet_ids.value[0][0]
  key_name               = local.terra_data.key_name.value
  vpc_security_group_ids = [local.terra_data.bastion_host_sg.value]
  tags = {
    Name = "bastion_host"
  }
}


output "PublicIP" {
  value = aws_instance.bastion_host.public_ip
}
