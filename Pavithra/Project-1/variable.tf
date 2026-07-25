variable "aws_region" {
  description = "aws region for resources"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "cidr block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet" {
  description = "cidr block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
  default     = "ap-south-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = " my public IP"
  type        = string
}

variable "owner" {
  description = "resource owner"
  type        = string
  default     = "Pavithra Machha"

}
variable "project_name" {
  description = "project name"
  type        = string
  default     = "terraform-project-1"
}

variable "Environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}

variable "key_name" {
  description = "key pair name"
  type        = string
  default     = "web-server-key"
}

variable "public_subnet_2" {
  description = "CIDR block for second public subnet"
  type        = string
  default     = "10.0.3.0/24"

}

variable "availability_zone_2" {
  description = "Availability Zone for second public subnet"
  type        = string
  default     = "ap-south-1b"
}
