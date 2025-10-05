variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "regions" {
  type    = set(string)
  default = ["eu-central-1", "eu-west-1"]
}
