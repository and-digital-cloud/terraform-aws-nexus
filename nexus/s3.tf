###########################
## Log bucket for Nexus  ##
###########################

resource "aws_s3_bucket" "log_bucket" {
  acl           = "private"
  bucket        = "${var.company_name}-dpm-${var.environment}-${var.service}-log-bucket"
  force_destroy = true
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true
    expiration {
      days = var.log_expire_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "access_log_bucket" {
  bucket                  = aws_s3_bucket.log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

################################
# Blob storage bucket for Nexus #
#################################
resource "aws_s3_bucket" "nexus" {
  acl           = "private"
  bucket        = "${var.company_name}-${var.environment}-${var.service}-bucket"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "nexus_log_bucket" {
  bucket                  = aws_s3_bucket.nexus.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}