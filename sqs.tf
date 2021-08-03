resource "aws_sqs_queue" "sqs" {
  count = (var.create_sqs == "yes") && (var.sqs_queue_type == "standard") ? length(var.queue_suffix) : 0

  name                       = "${var.app_name}_${element(var.queue_suffix, count.index)}"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  policy                     = data.aws_iam_policy_document.sqs_policy.json
  kms_master_key_id          = "alias/aws/sqs"
  tags                       = local.common_tags

}

resource "aws_sqs_queue" "sqs_fifo" {
  count = (var.create_sqs == "yes") && (var.sqs_queue_type == "fifo") ? length(var.queue_suffix) : 0

  name                        = "${var.app_name}_${element(var.queue_suffix, count.index)}.fifo"
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  policy                      = data.aws_iam_policy_document.sqs_policy.json
  fifo_queue                  = true
  content_based_deduplication = true
  kms_master_key_id           = "alias/aws/sqs"
  tags                        = local.common_tags
}