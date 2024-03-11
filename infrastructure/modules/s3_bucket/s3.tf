resource "aws_s3_bucket" "hyacinth_bucket" {
  bucket = "${local.resource_prefix}-bucket"

}

data "aws_iam_policy_document" "hyacinth_bucket_policy_doc" {
  statement {
    sid       = "DenyUnencryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.hyacinth_bucket.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }

  statement {
    sid       = "DenyPublicReadAccess"
    effect    = "Deny"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.hyacinth_bucket.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "hyacinth_bucket_policy" {
  bucket = aws_s3_bucket.hyacinth_bucket.id
  policy = data.aws_iam_policy_document.hyacinth_bucket_policy_doc.json
}

resource "aws_s3_bucket_public_access_block" "hyacinth_bucket_public_access_block" {
  bucket = aws_s3_bucket.hyacinth_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
