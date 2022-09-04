  
  #OCI
  variable "compartment_id" {}
  variable "region" {}

  #VCN
  variable "cidr_block" {}
  variable "display_name" {}
  variable "dns_label" {}

  #Subnet
  variable "subnet_cidr_block" {}
  variable "display_name_subnet" {}

  #Instance
  variable "instance_availability_domain" {}
  variable "instance_shape" {}
  variable "image_id" {}

  