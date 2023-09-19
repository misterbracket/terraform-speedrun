module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  comment             = "Apollo Goes Infra - ${var.developer_name}"
  enabled             = true
  http_version        = "http2and3"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false


  create_origin_access_control = true
  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    awesome_s3 = {
      domain_name           = module.website_s3_bucket.s3_bucket_bucket_regional_domain_name
      origin_access_control = "s3_oac" # key in `origin_access_control`
    }
  }

  default_cache_behavior = {
    target_origin_id       = "awesome_s3" # key in `origin` above
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 5400
    min_ttl     = 3600
    max_ttl     = 7200

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = false
    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.viewer_request.arn
      }
    }
  }

  default_root_object = "index.html"
}

resource "aws_cloudfront_function" "viewer_request" {
  name    = "my-awesome-cdn-viewer-request-${var.developer_name}"
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = file("${path.module}/viewer-request.js")
}
