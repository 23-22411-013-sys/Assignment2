# VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "The vpc_cidr_block must be a valid CIDR block."
  }
}

# Subnet CIDR block
variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.subnet_cidr_block))
    error_message = "The subnet_cidr_block must be a valid CIDR block."
  }
}

# Availability Zone
variable "availability_zone" {
  description = "Availability zone where resources will be deployed"
  type        = string
}

# Environment prefix
variable "env_prefix" {
  description = "Environment prefix used for resource naming (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"
}

# Public SSH key path
variable "public_key" {
  description = "Path to the public SSH key"
  type        = string
}

# Private SSH key path
variable "private_key" {
  description = "Path to the private SSH key"
  type        = string
  sensitive   = true
}

# Backend servers configuration
variable "backend_servers" {
  description = "List of backend servers with name and setup script path"
  type = list(object({
    name        = string
    script_path = string
  }))

  default = [
    {
      name        = "web-1"
      script_path = "scripts/apache-setup.sh"
    },
    {
      name        = "web-2"
      script_path = "scripts/apache-setup.sh"
    },
    {
      name        = "web-3"
      script_path = "scripts/apache-setup.sh"
    }
  ]
}
variable "my_ip" {
  description = "Public IP address for SSH access"
  type        = string
}
