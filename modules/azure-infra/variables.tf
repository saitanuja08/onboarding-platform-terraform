variable vnet_name {
  description = "The name of the VNet"
  type = string
}

variable public_subnet1_name {
  description = "The name of the public subnet 1"
  type = string
}

variable public_subnet2_name {
  description = "The name of the public subnet 2"
  type = string
}

variable private_subnet1_name {
  description = "The name of the private subnet 1"
  type = string
}

variable private_subnet2_name {
  description = "The name of the private subnet 2"
  type = string
}

variable route_table_name {
  description = "The name of the Route Table"
  type = string
}

variable vnet_cidr {
  description = "The Address Space for the VNet"
  type = list
}

variable public_subnet1_cidr {
  description = "The Address Space for the Public Subnet 1"
  type = list
}

variable public_subnet2_cidr {
  description = "The Address Space for the Public Subnet 2"
  type = list
}

variable private_subnet1_cidr {
  description = "The Address Space for the Private Subnet 1"
  type = list
}

variable private_subnet2_cidr {
  description = "The Address Space for the Private Subnet 2"
  type = list
}

variable resource_group_name {
  description = "The name of the resource group"
  type = string
}

variable location {
  description = "The location in which the resources must be created"
  type = string
}


