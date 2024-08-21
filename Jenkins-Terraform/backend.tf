terraform {
  backend "s3" {
    bucket = "terraform-eks-jenkins-kartik"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-eks-jenkins-locks"
  }
}