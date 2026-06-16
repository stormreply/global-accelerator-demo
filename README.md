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

1. In your account, go to the _Global Accelerator service_ page
1. Under _Accelerators_, click the accelerator link with the
   _global-accelerator-demo_ infix.
1. Check the details on the next page. Under _Listeners_, you
   will find a single Listener on port 80. Follow the link in
   the column _Listener ID_.
1. On the next page, you will find two _Endpoint groups_, one in
   region _eu-central-1_, with a _Traffic dial_ of 90%, and one in
   region _eu-west-1_, with a _traffic dial_ of 10%.
1. Note the links in the _Endpoint group ID_ column. Click both
   these two links, one after the other.
1. The next page will show you two _Endpoints_, pointing to Elastic
   Load Balancers. Note their respektive _Weight_: In _eu-central-1_,
   one has a _Weight_ of 192, the other one has a _Weight_ of 64.
   For _eu-west-1_, the _Weight_ is 128 for both endpoints.

1. Now switch to the _Apply_ workflow in Github from where you
   built this demo. On the top left of the workflow run page, click
   on _Summary_.
1. Scroll to the bottom of the _Summary_ page. Note that it does
   not let you scroll there from everywhere on the page. Position
   your mouse pointer on the left edge of the page in order to be
   able to scroll down to the bottom.
1. Under _Artifacts_, you will find an artifact ending on _-test.sh_.
   Download it. If it comes as a _.zip_ file, double click it in
   order to unzip it. As a result, you should receive a Shell script
   ending on _-test.sh_ in your _Downloads_ folder.
1. On the Github _Apply_ workflow summary page, you will also find
   an _Output_ section showing the _Global Accelerator_ URL. Copy
   that URL into your Clipboard.
1. Now, in a Shell terminal, run the _-test.sh_ script using bash:

   ```bash <path>/<prefix>-test.sh <global accelerator url>```

   That line is probably gonna look something like

   ```bash ~/Downloads/slt-...-test.sh http://...awsglobalaccelerator.com```

1. Hit _Enter_ and execute the script. It will call the Global
   Accelerator URL 40 times, using curl. As output, the script will
   show the name of each instance it was directed to by Global
   Accelerator. You will recognize a region shortcut as part of
   the name, like _euc1_ and _euw1_, and a _0_ or a _1_ at the
   end, representing either endpoint in that region.
1. You can add the number of calls to Global Accelerator as a
   second parameter to the script if you like, and also interrupt
   the script using Control-C. In any case, the script will show
   percentage rates at the end about how often each endpoint was
   called. The first two endpoints in that sorted list should
   amount to (more or less) some 90% - corresponding to the
   _dial_ value.
1. Now use the Global Accelerator URL in a browser window input
   field and hit _Enter_. Its output in the browser will show
   the Instance ID and the Instance Name. Reload that page,
   maybe 10 or 20 times. The output does not really change often.
   It seems to stick with the same value(s) for quite some time.
   Why?
1. Now append _/proxy_ to the Global Accelerator URL in the
   browser window's input, hit _Enter_ and reload a couple times.
   The output seems to change much more often now. Why?

   The answer is in the code. Try to think about it first.
   While doing so, replace _/proxy_ with _/demo.html_ in the
   browser input, hit _Enter_ and enjoy a little demo.

   ...

1.

<details>
<summary><h2>Terraform Docs</h2></summary>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3 |

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
| [aws\_iam\_instance\_profile.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws\_iam\_role.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws\_iam\_role\_policy.web\_s3\_assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws\_launch\_template.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws\_lb.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws\_lb\_listener.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws\_lb\_listener\_rule.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws\_lb\_target\_group.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws\_lb\_target\_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws\_s3\_bucket.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws\_s3\_bucket\_public\_access\_block.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws\_s3\_object.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws\_security\_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [null\_resource.copy\_test\_script](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws\_ami.amazon\_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws\_availability\_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [cloudinit\_config.web](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

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
