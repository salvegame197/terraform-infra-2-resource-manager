terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = var.region
}

resource "oci_core_vcn" "internal" {
  # dns_label      = var.dns_label
  cidr_block     = var.cidr_block
  compartment_id = var.compartment_id
  display_name   = var.display_name
}

resource "oci_core_subnet" "test_subnet" {
    cidr_block = var.subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.internal.id
    display_name = var.display_name_subnet
}

resource "oci_core_instance" "testeInstance" {
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.instance_shape
    count = var.num_instances

    metadata = {
      ssh_authorized_keys = var.ssh_public_key
    }

    shape_config {
      ocpus = var.instance_shape_config_ocpus
      memory_in_gbs = var.instance_shape_config_memory_in_gbs
    }

    create_vnic_details {
        subnet_id = oci_core_subnet.test_subnet.id
        assign_public_ip = false
        display_name = oci_core_subnet.test_subnet.display_name
    }
    source_details {
        source_id = var.image_id
        source_type = "image"
    }
}