
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = "${local.resource_prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs =  [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]
  private_subnet_tags = {
  }

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
  ]
  public_subnet_tags = {
    public = "true"
  }
  map_public_ip_on_launch = true

  enable_nat_gateway = true
  single_nat_gateway = true
  create_igw         = true

}
