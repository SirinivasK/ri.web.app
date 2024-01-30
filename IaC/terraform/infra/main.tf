data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["sts:AssumeRole"]
  }
}

resource "aws_instance" "this" {
  ami                  = terraform.workspace == "graviton" ? data.aws_ami.this.id : "ami-amazon-linux-latest"
  instance_type        = var.instance_type
  subnet_id            = var.subnetid
  key_name             = var.keyname
  security_groups      = [aws_security_group.this.id]
  iam_instance_profile = aws_iam_instance_profile.this.id
}

resource "aws_security_group" "this" {
  name        = "bastion_sg"
  description = "Security group for bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "this" {
  name = "test_profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name               = "ec2_role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}