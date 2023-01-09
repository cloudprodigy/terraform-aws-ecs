# get AWS account number
data "aws_caller_identity" "current" {}

# get current region
data "aws_region" "current" {}

# ECR Crossaccount policy

data "aws_iam_policy_document" "ecr" {
  count = local.environment == "dev" ? 1 : 0
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy"
    ]
    principals {
      type = "AWS"
      identifiers = [ # ECR repo is created in Dev environment and access is granted to other AWS environment (test, prod, etc)
        "arn:aws:iam::ACCOUNT1:root",
        "arn:aws:iam::ACCOUNT2:root"
      ]
    }
  }
}