module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "VPC"

  azs                = ["us-east-1a", "us-east-1b"]
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = true
  private_subnets    = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24"]
}
