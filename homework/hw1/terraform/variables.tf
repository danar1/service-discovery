variable "region" {
  description = "AWS region for VMs"
  default = "us-east-1"
}


variable "ubuntu_ami_owner" {
  description = "Ubuntu AMI owner"
  default = "099720109477"
}


variable "consul_servers_count" {
  description = "Number of consul servers to create"
  default = 3
}

variable "consul_agent_count" {
  description = "Number of consul agents to create"
  default = 1
}


variable "vpc_id" {
  description = "AWS VPC id"
  default     = "vpc-a0d417dd"
}

variable "subnet_id" {
  description = "Ansible Subnet id"
  default     = "subnet-403c8c1f"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22]
}

