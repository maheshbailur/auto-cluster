provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "kubevprofile-kops-state"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}

resource "aws_key_pair" "cluster-key" {
  key_name   = "${local.key_name}"
  public_key = file("~/.ssh/id_rsa.pub")
}

locals {
  azs                    = ["us-east-2a"]
  environment            = "kubevprofile"
  kops_state_bucket_name = "${local.environment}-kops-state"
  // Needs to be a FQDN
  kubernetes_cluster_name = "kubevpro.bailurtech.xyz"
  ingress_ips             = ["10.0.0.100/32", "10.0.0.101/32"]
  vpc_name                = "${local.environment}-vpc"
  key_name                = "clusterkey"

  tags = {
    environment = "${local.environment}"
    terraform   = true
  }
}

data "aws_region" "current" {}
