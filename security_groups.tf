resource "aws_security_group" "this" {
  count       = var.enabled ? 1 : 0
  name        = var.es_domain
  description = "ElasticSearch Domain for ${var.es_domain}"
  vpc_id      = data.aws_vpc.this[0].id
  tags = merge({
    "Name" = var.es_domain
    },
    local.default_tags, var.tags
    )
}

resource "aws_security_group_rule" "vpc_ingress" {
  count             = var.enabled ? 1 : 0
  security_group_id = aws_security_group.this[0].id
  description       = "Allow inbound traffic to the ES Cluster from the VPC CDIR"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.this[0].cidr_block]
}

resource "aws_security_group_rule" "source_sg_ingress" {
  count             = var.enabled && length(var.security_groups_ingress_source) > 0 ? 1 : 0
  security_group_id = aws_security_group.this[0].id
  description       = "Allow inbound traffic to the ES Cluster from source Security Groups"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = var.security_groups_ingress_source[count.index]
}

resource "aws_security_group_rule" "egress" {
  count             = var.enabled ? 1 : 0
  security_group_id = aws_security_group.this[0].id
  description       = "Allow all outbound traffic from the ES Cluster"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

}