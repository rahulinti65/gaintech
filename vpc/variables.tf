variable "cidr_block" {

    description = "cidr block for vpc"
    default = "10.0.0.0/16"
    }
  
variable "destination_cidr"  {
    description = "destination cidr block"
    default = "0.0.0.0/0"
} 