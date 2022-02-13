resource "aws_cloudfront_distribution" "create_cloudfront_distribution" {
  enabled = true
  aliases = [replace(var.domain_name, "/^https?:\\/\\//", "")]

  provider = aws.us-east-1

  origin {
    domain_name = replace(module.api_gateway.apigatewayv2_api_api_endpoint, "/^https?:\\/\\//", "")
    origin_id   = "todoapp-backend-api"
    origin_path = ""

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    domain_name = aws_s3_bucket.create_bucket_s3.website_endpoint
    origin_id   = aws_s3_bucket.create_bucket_s3.bucket
    origin_path = ""

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "IDP_METADATA_URL"
      value = var.openid_config.IDP_METADATA_URL
    }

    custom_header {
      name  = "DOMAIN"
      value = var.domain_name
    }

    custom_header {
      name  = "CLIENT_ID"
      value = var.openid_config.CLIENT_ID
    }

    custom_header {
      name  = "CLIENT_SECRET"
      value = var.openid_config.CLIENT_SECRET
    }
  }

  default_cache_behavior {
    allowed_methods        = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods         = ["HEAD", "GET"]
    target_origin_id       = aws_s3_bucket.create_bucket_s3.bucket
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 0
    max_ttl     = 0
    min_ttl     = 0


    forwarded_values {
      query_string = true

      cookies {
        forward           = "whitelist"
        whitelisted_names = ["authorization"]
      }

      headers = ["origin"]
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = "${module.create_openid_client.lambda_function_arn}:${module.create_openid_client.lambda_function_version}"
    }
  }

  ordered_cache_behavior {
    allowed_methods        = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods         = ["HEAD", "GET"]
    path_pattern           = "/api/*"
    target_origin_id       = "${var.name_prefix}-backend-api"
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 0
    max_ttl     = 0
    min_ttl     = 0

    forwarded_values {
      query_string = true
      cookies {
        forward           = "whitelist"
        whitelisted_names = ["authorization"]
      }

      headers = ["origin"]
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = "${module.create_openid_client.lambda_function_arn}:${module.create_openid_client.lambda_function_version}"
    }
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = var.domain_certificate_arn
    ssl_support_method  = "sni-only"
  }
}