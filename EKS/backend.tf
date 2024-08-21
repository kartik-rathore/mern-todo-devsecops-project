terraform {
  backend "s3" {
    bucket = "terraform-eks-jenkins-kartik"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}