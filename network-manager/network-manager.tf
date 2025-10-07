resource "aws_networkmanager_global_network" "demo" {
  description = "Global network for ${var.deployment.name} - Global Accelerator deployment"

  tags = {
    Name = "${var.deployment.name}-global-network"
  }
}

resource "aws_networkmanager_core_network" "demo" {
  global_network_id = aws_networkmanager_global_network.demo.id
  description       = "Core network for ${var.deployment.name} Global Accelerator topology"

  tags = {
    Name = "${var.deployment.name}-core-network"
  }
}
