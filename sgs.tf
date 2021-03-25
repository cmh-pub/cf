module "external-ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "external-ssh"
  description = "Allow external SSH"
  vpc_id      = module.vpc.vpc_id

  egress_rules        = ["all-all"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
}
module "internal-web" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "internal-web"
  description = "Allow internal Web"
  vpc_id      = module.vpc.vpc_id

  egress_rules        = ["all-all"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp"]
}

module "external-web" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "external-web"
  description = "Allow external Web"
  vpc_id      = module.vpc.vpc_id

  egress_rules        = ["all-all"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
}