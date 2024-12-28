module "vpc" {
    source = "cloudposse/vpc/aws"
    version = "2.1.1"

    namespace = "eg"
    stage     = "test"
    name      = "app"

    ipv4_primary_cidr_block = var.cidr_block
    default_route_table_no_routes = true
    default_security_group_deny_all = true
    assign_generated_ipv6_cidr_block = false
    dns_hostnames_enabled = true
    
    
}

data "aws_availability_zones" "available" {
  
}

data "aws_vpc" "available" {}

module "dynamic_subnets" {
  source = "cloudposse/dynamic-subnets/aws"
  namespace          = "eg"
  stage              = "test"
  name               = "app"
  vpc_id             = module.vpc.vpc_id
  igw_id             = [module.vpc.igw_id]
  public_route_table_enabled = false
  public_subnets_enabled = true
  private_route_table_enabled = true
  private_subnets_enabled = true
  nat_gateway_enabled = true
  availability_zones = slice(data.aws_availability_zones.available.names, 0,1)

                             
}                             

resource "aws_route" "default" {
    route_table_id = module.vpc.vpc_main_route_table_id
    destination_cidr_block = var.destination_cidr
    gateway_id = module.vpc.igw_id 
}


  