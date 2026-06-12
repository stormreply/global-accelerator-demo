### Storm Library for Terraform
# Global Accelerator Demo

A demo of AWS Global Accelerator showing dial, weight and failover.

[![Check](https://github.com/stormreply/slt-member-example/actions/workflows/check.yaml/badge.svg)](https://github.com/stormreply/slt-member-example/actions/workflows/check.yaml)
[![Plan](https://github.com/stormreply/slt-member-example/actions/workflows/plan.yaml/badge.svg)](https://github.com/stormreply/slt-member-example/actions/workflows/plan.yaml)
[![Apply](https://github.com/stormreply/slt-member-example/actions/workflows/apply.yaml/badge.svg)](https://github.com/stormreply/slt-member-example/actions/workflows/apply.yaml)
[![Test](https://github.com/stormreply/slt-member-example/actions/workflows/test.yaml/badge.svg)](https://github.com/stormreply/slt-member-example/actions/workflows/test.yaml)
[![Destroy](https://github.com/stormreply/slt-member-example/actions/workflows/destroy.yaml/badge.svg)](https://github.com/stormreply/slt-member-example/actions/workflows/destroy.yaml)

This repository is a member of the SLT | Storm Library for Terraform,
a collection of Terraform modules for Amazon Web Services. The focus
of these modules, maintained in separate GitHub™ repositories, is on
building examples, demos and showcases on AWS. The audience of the
library is learners and presenters alike - people that want to know
or show how a certain service, pattern or solution looks like, or "feels".

[Learn more](https://github.com/stormreply/storm-library-for-terraform)

## Installation

This demo can be built using GitHub Actions. In order to do so

- [Install the Storm Library for Terraform](https://github.com/stormreply/storm-library-for-terraform/blob/main/docs/INSTALL-LIBRARY.md)
- [Deploy this member repository](https://github.com/stormreply/storm-library-for-terraform/blob/main/docs/DEPLOY-MEMBER.md)

Deployment of this member should take less than 4 minutes on GitHub resources.

## Architecture

![Architecture](assets/architecture.drawio.svg)

## Explore this demo

Follow these steps in order to explore this demo:

1. TBD
1. ...

<details>
<summary><h2>Terraform Docs</h2></summary>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws\_autoscaling\_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws\_default\_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet) | resource |
| [aws\_default\_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc) | resource |
| [aws\_globalaccelerator\_accelerator.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_accelerator) | resource |
| [aws\_globalaccelerator\_endpoint\_group.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_endpoint_group) | resource |
| [aws\_globalaccelerator\_listener.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_listener) | resource |
| [aws\_launch\_template.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws\_lb.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws\_lb\_listener.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws\_lb\_target\_group.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws\_security\_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws\_ami.amazon\_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws\_availability\_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input__metadata"></a> [\_metadata](#input\_\_metadata) | Select metadata passed from GitHub Workflows | <pre>object({<br/>    actor      = string # Github actor (deployer) of the deployment<br/>    catalog_id = string # SLT catalog id of this module<br/>    deployment = string # slt-<catalod_id>-<repo>-<actor><br/>    ref        = string # Git reference of the deployment<br/>    ref_name   = string # Git ref_name (branch) of the deployment<br/>    repo       = string # GitHub short repository name (without owner) of the deployment<br/>    repository = string # GitHub full repository name (including owner) of the deployment<br/>    sha        = string # Git (full-length, 40 char) commit SHA of the deployment<br/>    short_name = string # slt-<catalog_id>-<actor><br/>    time       = string # Timestamp of the deployment<br/>  })</pre> | <pre>{<br/>  "actor": "",<br/>  "catalog_id": "",<br/>  "deployment": "",<br/>  "ref": "",<br/>  "ref_name": "",<br/>  "repo": "",<br/>  "repository": "",<br/>  "sha": "",<br/>  "short_name": "",<br/>  "time": ""<br/>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type to be used for the Global Accelerator endpoints | `string` | `"t3.micro"` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | A map of regions where endpoints for this Global Accelerator<br/>are to be configured. Keys of this map are region names like<br/>e.g. "eu-central-1", values are objects as seen in the type<br/>definition. | <pre>map(object({<br/>    traffic_dial_percentage        = number<br/>    endpoint_configuration_weights = list(number)<br/>  }))</pre> | <pre>{<br/>  "eu-central-1": {<br/>    "endpoint_configuration_weights": [<br/>      192,<br/>      64<br/>    ],<br/>    "traffic_dial_percentage": "90"<br/>  },<br/>  "eu-west-1": {<br/>    "endpoint_configuration_weights": [<br/>      128,<br/>      128<br/>    ],<br/>    "traffic_dial_percentage": "10"<br/>  }<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__slt_config"></a> [\_slt\_config](#output\_\_slt\_config) | Map of SLT configuration |
| <a name="output__summary"></a> [\_summary](#output\_\_summary) | Key-value pairs to be published in the GITHUB\_STEP\_SUMMARY |
| <a name="output_artifact"></a> [artifact](#output\_artifact) | Artifact: A test script curl'ing the Global Accelerator URL |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | Availability zones of the regions operated. Helpful with the zone\_ids. |
| <a name="output_endpoint_groups"></a> [endpoint\_groups](#output\_endpoint\_groups) | The Global Accelerator endpoint groups |
| <a name="output_global_accelerator"></a> [global\_accelerator](#output\_global\_accelerator) | The Global Accelerator terraform object |
| <a name="output_local_loadbalancers"></a> [local\_loadbalancers](#output\_local\_loadbalancers) | A list with all terraform loadbalancer objects involved<br/>in this Global Accelerator setup. |
| <a name="output_regions"></a> [regions](#output\_regions) | The configuration of all regions involved in this Global<br/>Accelerator setup. |
<!-- END_TF_DOCS -->

</details>
