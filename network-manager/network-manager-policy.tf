resource "aws_networkmanager_core_network_policy_attachment" "demo" {
  core_network_id = aws_networkmanager_core_network.demo.id
  policy_document = jsonencode({
    version = "2021.12"
    core-network-configuration = {
      vpn-ecmp-support = false
      asn-ranges       = ["64512-64520"]
      edge-locations = [
        for region in keys(var.regions) : {
          location = region
          asn      = 64512 + index(keys(var.regions), region)
        }
      ]
    }
    segments = [
      {
        name                          = "production"
        description                   = "Production segment for ${var.name_tag}"
        require-attachment-acceptance = false
        edge-locations                = keys(var.regions)
      }
    ]
    # segment-actions = [
    #   {
    #     action  = "share"
    #     mode    = "attachment-route"
    #     segment = "production"
    #     share-with = [
    #       "*"
    #     ]
    #   }
    # ]
    # attachment-policies = [
    #   {
    #     rule-number     = 100
    #     condition-logic = "or"
    #     conditions = [
    #       {
    #         type = "tag-exists"
    #         key  = "Region"
    #       }
    #     ]
    #     action = {
    #       association-method = "constant"
    #       segment            = "production"
    #     }
    #   }
    # ]
  })
}
