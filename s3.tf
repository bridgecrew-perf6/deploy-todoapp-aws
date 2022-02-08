resource "aws_s3_bucket" "create_bucket_s3" {
  bucket = "todoapp-s3"
  acl    = "public-read"
  policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::todoapp-s3/*"
    }
  ]
}
EOF

  provider = aws.eu-south-1

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

locals {
  website_files = fileset(var.website_root, "**")

  mime_types = jsondecode(file("mime.json"))
}

resource "aws_s3_bucket_object" "upload_static_files_s3" {

  for_each = local.website_files

  provider = aws.eu-south-1

  bucket       = aws_s3_bucket.create_bucket_s3.id
  key          = each.key
  source       = "${var.website_root}/${each.key}"
  source_hash  = filesha256("${var.website_root}/${each.key}")
  acl          = "public-read"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
}