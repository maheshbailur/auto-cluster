//Used to allow web access to the k8s API ELB
resource "aws_security_group" "k8s_common_http" {
  name   = "${local.environment}_k8s_common_http"
  vpc_id = "${module.dev_vpc.vpc_id}"
  tags   = "${merge(local.tags)}"

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = local.ingress_ips
  }

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = local.ingress_ips
  }
}

//Used to allow access to the bastion host
resource "aws_security_group" "bastion_host_sg" {
  vpc_id      = "${module.dev_vpc.vpc_id}"
  name        = "${local.environment}_k8s_bastion_sg"
  description = "Sec Grp for bastion to allow ssh"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["100.10.10.10/32"]
  }
}