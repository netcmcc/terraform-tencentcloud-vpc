# terraform-tencentcloud-vpc

Terraform module to provision a VPC with NAT Gateway on Tencent Cloud. Support creating ENI subnet for use by TKE cluster.

## Example

```hcl
module "vpc" {
  source = "github.com/wootile/terraform-tencentcloud-vpc"

  enabled  = true
  vpc_name = "chenming-gz"
  vpc_cidr = "172.20.0.0/16"

  availability_zones = ["ap-guangzhou-6", "ap-guangzhou-7"]
  subnet_cidrs       = ["172.20.0.0/23", "172.20.2.0/23"]
  eni_subnet_cidrs   = ["172.20.8.0/22", "172.20.12.0/22"]
  enable_nat_gateway = false

  tags = {
    "onwer" = "chenming"
  }
}

provider "tencentcloud" {
  region = "ap-guangzhou"
}

terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">= 1.81"
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >= 1.81.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >= 1.81.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_eip.nat_eip](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/eip) | resource |
| [tencentcloud_nat_gateway.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/nat_gateway) | resource |
| [tencentcloud_nat_gateway_snat.snat](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/nat_gateway_snat) | resource |
| [tencentcloud_nat_gateway_snat.snat_eni](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/nat_gateway_snat) | resource |
| [tencentcloud_route_table.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/route_table) | resource |
| [tencentcloud_route_table_entry.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/route_table_entry) | resource |
| [tencentcloud_subnet.eni_subnet](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/subnet) | resource |
| [tencentcloud_subnet.subnet](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/subnet) | resource |
| [tencentcloud_vpc.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of available zones to launch resources. | `list(string)` | `[]` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Should be true if you want to provision NAT Gateways. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_eni_subnet_cidrs"></a> [eni\_subnet\_cidrs](#input\_eni\_subnet\_cidrs) | Specify the Pod subnet cidr blocks. | `list(string)` | `[]` | no |
| <a name="input_nat_eip_max_bandwidth"></a> [nat\_eip\_max\_bandwidth](#input\_nat\_eip\_max\_bandwidth) | Set the maximum bandwidth of the EIP associated with the NAT gateway. | `number` | `100` | no |
| <a name="input_subnet_cidrs"></a> [subnet\_cidrs](#input\_subnet\_cidrs) | Specify the subnet cidr blocks. | `list(string)` | `[]` | no |
| <a name="input_subnet_is_multicast"></a> [subnet\_is\_multicast](#input\_subnet\_is\_multicast) | Specify the subnet is multicast. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The cidr block. | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vpc_dns_servers"></a> [vpc\_dns\_servers](#input\_vpc\_dns\_servers) | Specify the vpc dns servers. | `list(string)` | `[]` | no |
| <a name="input_vpc_is_multicast"></a> [vpc\_is\_multicast](#input\_vpc\_is\_multicast) | Specify the vpc is multicast. | `bool` | `true` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The vpc name. | `string` | `"tf-modules-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zone of subnet. |
| <a name="output_eni_subnet_ids"></a> [eni\_subnet\_ids](#output\_eni\_subnet\_ids) | The id of ENI subnet. |
| <a name="output_nat_gateway_eip"></a> [nat\_gateway\_eip](#output\_nat\_gateway\_eip) | The EIP address associated with the NAT gateway. |
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The id of route table. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The id of subnet. |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | The CIDR block of vpc. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The id of vpc. |
<!-- END_TF_DOCS -->