# cf

Required Prexisting Setup:

This code requires you to have an SSH key already defined in the target AWS account. At runtime it will prompt you for the key name.

Required Environment Variables:

AWS_ACCESS_KEY_ID  
AWS_SECRET_ACCESS_KEY  

Modules Used:  
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest  
https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest  
https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest  
https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest  
