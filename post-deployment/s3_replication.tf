data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "replication" {
  name               = format("%s-sales-s3-replication", var.bucket_prefix_name)
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {

  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = [
      format("%s", data.aws_s3_bucket.primary.arn),
      format("%s", data.aws_s3_bucket.secondary.arn),
      format("%s/*", data.aws_s3_bucket.primary.arn),
      format("%s/*", data.aws_s3_bucket.secondary.arn),
    ]
  }

}

resource "aws_iam_policy" "replication" {
  name        = format("%s-sales-s3-replication", var.bucket_prefix_name)
  description = "Policy for S3 replication"
  policy      = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_policy.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket_replication_configuration" "primary" {
  role   = aws_iam_role.replication.arn
  bucket = data.aws_s3_bucket.primary.id

  rule {
    id = "sales"

    status = "Enabled"

    filter {
      prefix = "sales"
    }

    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket        = data.aws_s3_bucket.secondary.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_replication_configuration" "secondary" {
  provider = aws.secondary
  role     = aws_iam_role.replication.arn
  bucket   = data.aws_s3_bucket.secondary.id

  rule {
    id = "sales"

    status = "Enabled"

    filter {
      prefix = "sales"
    }

    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket        = data.aws_s3_bucket.primary.arn
      storage_class = "STANDARD"
    }
  }
}
