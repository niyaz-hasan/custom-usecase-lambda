variable "ec2_instance_ids" {
  description = "Comma-separated list of EC2 instance IDs"
  type        = string
  default     = "i-02d143846751d6a81"
}

variable "aws_region" {
  description = "region"
  type        = string
  default     = "us-east-1"
}
