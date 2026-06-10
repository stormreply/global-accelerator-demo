variable "instance_type" {
  description = <<-EOD
    EC2 instance type to be used for the Global Accelerator endpoints
  EOD
  type        = string
  default     = "t3.micro"
}

variable "regions" {
  description = <<-EOD
    A map of regions where endpoints for this Global Accelerator
    are to be configured. Keys of this map are region names like
    e.g. "eu-central-1", values are objects as seen in the type
    definition.
  EOD

  type = map(object({
    traffic_dial_percentage        = number
    endpoint_configuration_weights = list(number)
  }))
  default = {
    "eu-central-1" = {
      traffic_dial_percentage        = "90"
      endpoint_configuration_weights = [192, 64] # use a 3:1 distribution
    }
    "eu-west-1" = {
      traffic_dial_percentage        = "10"
      endpoint_configuration_weights = [128, 128] # use a 1:1 distribution
    }
  }
}
