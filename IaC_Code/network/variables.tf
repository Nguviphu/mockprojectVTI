variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.97.0.0/16" # Đã đổi dải IP gốc
}