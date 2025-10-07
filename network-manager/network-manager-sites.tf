resource "aws_networkmanager_site" "regional" {
  for_each = var.regions

  global_network_id = aws_networkmanager_global_network.demo.id
  description       = "Regional site for ${each.key}"

  location {
    latitude  = local.region_coordinates[each.key].latitude
    longitude = local.region_coordinates[each.key].longitude
  }

  tags = {
    Name                  = "${var.deployment.name}-site-${each.key}"
    Region                = each.key
    TrafficDialPercentage = each.value.traffic_dial_percentage
  }
}

locals {
  region_coordinates = {
    "eu-central-1" = {
      latitude  = "50.1109"
      longitude = "8.6821"
    }
    "eu-west-1" = {
      latitude  = "53.3498"
      longitude = "-6.2603"
    }
    # "us-east-1" = {
    #   latitude  = "39.0438"
    #   longitude = "-77.4874"
    # }
    # "us-west-1" = {
    #   latitude  = "37.3382"
    #   longitude = "-121.8863"
    # }
    # "us-west-2" = {
    #   latitude  = "45.5152"
    #   longitude = "-122.6784"
    # }
    # "ap-southeast-1" = {
    #   latitude  = "1.3521"
    #   longitude = "103.8198"
    # }
    # "ap-northeast-1" = {
    #   latitude  = "35.6762"
    #   longitude = "139.6503"
    # }
  }
}
