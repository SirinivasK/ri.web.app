variable "vpc" {
  default     = "add vpc here"
  description = "add your VPC value here"
}

variable "subnetid" {
  default     = "add subnet here"
  description = "add your subnet id here"
}

variable "keyname" {
  default     = "add ssh key"
  description = "add your ssh key details here"
}

variable "instance_type" {
  default     = "t3.nano"
  description = "specify the EC2 instance type"
}