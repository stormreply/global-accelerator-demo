variable "regions" {
  type = map(object({
    traffic_dial_percentage        = number
    endpoint_configuration_weights = list(number)
  }))
  default = {
    "eu-central-1" = {
      traffic_dial_percentage        = "100"
      endpoint_configuration_weights = [128, 32]
    }
    "eu-west-1" = {
      traffic_dial_percentage        = "100"
      endpoint_configuration_weights = [128, 32]
    }
  }
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
