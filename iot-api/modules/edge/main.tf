####################################################
# IoT policy
####################################################
resource "aws_iot_policy" "subscribe_iot" {
  name = "${var.name_prefix}_subscribe_iot"

  policy = templatefile(
    "${path.module}/templates/iot_subscribe.json",
    {}
  )
}
