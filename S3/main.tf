# Define the S3 bucket for storing Terraform state
resource "aws_s3_bucket" "terraform-eks-jenkins" {
  bucket = "terraform-eks-jenkins-kartik"
  # Enable versioning to see the full revision history of the state file
  versioning {
    enabled = true
  }

  tags = {
    Name        = "terraform-eks-jenkins"
    Environment = "Dev"
  }
}

# Define the DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform-locks" {
  name           = "terraform-eks-jenkins-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-eks-jenkins-locks"
    Environment = "Dev"
  }
}

