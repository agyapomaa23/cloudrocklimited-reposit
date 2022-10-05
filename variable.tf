variable "cidr-for-main-vpc" {
description = "the cidr for main vpc"
default = "10.0.0.0/16"
type = string
}

variable "cidr-for-public-subnet" {
description = "the cidr for public subnet"
default = "10.0.1.0/24"
type = string
}

variable "cidr-for-private-subnet" {
description = "the cidr for private subnet"
default =  "10.0.3.0/24"
type = string
}


variable "region-name" {
description = "name of region"
default = "eu-west-2" 
type = string
}


variable "Instance-Type" {
description = "Type of instance"
default = "t2.micro" 
type = string
}

