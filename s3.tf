
#####################
## Create S3 bucket##
#####################

# We use the module from https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
# A module is a piece of code that is reusable. Think of it as a function.
# We are using the module to create an S3 bucket and pass in the parameters of how we want it to be created.



# There are three types of resources in Terraform:
# 1. Data sources
# 2. Resources
# 3. Modules

# When distinguishing from data resources, the primary kind of resource (as declared by a resource block) 
# is known as a managed resource. Both kinds of resources take arguments and export attributes for use in 
# configuration, but while managed resources cause Terraform to create, update, and delete infrastructure 
# objects, data resources cause Terraform only to read objects. For brevity, managed resources are often 
# referred to just as "resources" when the meaning is clear from context.

module "website_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "apollo-goes-infra-lisbon-2023-${var.developer_name}"
  force_destroy = true
}

data "aws_iam_policy_document" "s3_policy" {
  # Origin Access Controls
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.website_s3_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [module.cdn.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.website_s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}

