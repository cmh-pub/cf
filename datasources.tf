data "aws_ami" "redhat-linux-8" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-8.*x86_64*Hourly2*"]
  }
}