data "aws_iam_policy_document" "eks_cluster_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type = "Service"

      identifiers = [
        "eks.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "eks_node_group_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}