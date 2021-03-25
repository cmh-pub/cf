locals {
  user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl enable httpd
systemctl start httpd
EOF
}

module "ec2-public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name = "ec2-public"

  ami            = data.aws_ami.redhat-linux-8.id
  instance_count = 1
  instance_type  = "t2.micro"
  key_name       = var.sshkey
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    },
  ]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.external-ssh.this_security_group_id]
}

module "ec2-private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name = "ec2-private"

  ami            = data.aws_ami.redhat-linux-8.id
  instance_count = 1
  instance_type  = "t2.micro"
  key_name       = var.sshkey
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    },
  ]
  subnet_id              = module.vpc.private_subnets[0]
  user_data              = local.user_data
  vpc_security_group_ids = [module.internal-web.this_security_group_id]
}