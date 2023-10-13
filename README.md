# terraform-aws-elasticsearch-module

**This module is no longer being maintained** <br/>

A Terraform module to provision an ElasticSearch cluster and dependent resources. Has been tested with Terraform 12.26, but should support Terraform 13 and above. This module does not create the service linked role required to provision an ES Domain within a VPC. Further context can be found in the [ADR](docs/adr/0003-provisoning-service-link-role-is-outside-the-scope-of-this-module.md).

 ---

 ## Architectural Decision Records

Important architectural decisions along with their context and consequences are
captured in <a
href="https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records">Lightweight Architecture Decision Records</a>
stored in this repository. These <a
href="http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions">Architecture
Decision Records</a> (ADRs) are created, updated and maintained using the <a
href="https://github.com/npryce/adr-tools">ADR Tools</a>. Instructions for
installing the tools can be found <a
href="https://github.com/npryce/adr-tools/blob/master/INSTALL.md">here</a>.

Please read the [ADRs](docs/adr/toc.md) for this module to
understand the important architectural decisions that have been made.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.21.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cdir\_blocks | A List of cdir blocks to assign to the VCP security group | `list(string)` | `[]` | no |
| automated\_snapshot\_start\_hour | The hour(`UTC`) when snapshots are taken | `number` | `12` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | n/a | yes |
| enforce\_https\_for\_es\_domain\_endpoint | Controls if the Elastic Search Domain endpoint is restricted to https only. Defaults to `true` | `bool` | `true` | no |
| es\_access\_policy\_statements | A list of IAM settings that build a number of IAM policy statements, that define the access policy for the cluster | <pre>list(object({<br>    name          = string<br>    actions       = list(string)<br>    resource_path = string<br>    role          = string<br>  }))</pre> | `null` | no |
| es\_advanced\_options | Advanced configuration options in JSON format | `map(any)` | `null` | no |
| es\_advanced\_security\_options\_enabled | Enables Fine Grained Access Control within the ElasticSearch domain. This will require a management process to map IAM roles to ElasticSearch principals | `bool` | `true` | no |
| es\_az\_aware | Controls if the ElasticSeach domain should be AZ aware | `bool` | `true` | no |
| es\_az\_count | The number of AZ's to use in theElasticSearch domain cluster. Not applied if `use_all_azs_in_region` is `true`. | `number` | `1` | no |
| es\_data\_node\_count | The number of data nodes for the ElasticSearch Domain. | `number` | `3` | no |
| es\_data\_node\_instance\_type | The instance type for the ElasticSearch data nodes | `string` | `"t3.small.elasticsearch"` | no |
| es\_dedicated\_node\_count | The number of dedicated nodes for the ElasticSearch Domain. | `number` | `1` | no |
| es\_dedicated\_node\_enabled | Determines if the cluster should provision dedicated cluster nodes. | `bool` | `false` | no |
| es\_dedicated\_node\_instance\_type | The instance type for the ElasticSearch dedicated nodes | `string` | `"t3.small.elasticsearch"` | no |
| es\_domain\_name | Name for the Elastic Search Domain.  Must start with a alphabet and be at least 3 and no more than 28 characters long. | `string` | `null` | no |
| es\_ebs\_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type. | `number` | `0` | no |
| es\_ebs\_volume\_size | The size of EBS volumes attached to data nodes (in GiB). EBS volumes are attached to data nodes in the domain when this value is > `0`. | `number` | `0` | no |
| es\_ebs\_volume\_type | The type of EBS volumes attached to data nodes. | `string` | `"gp2"` | no |
| es\_encryption\_enabled | Enables encryption (at rest) for data in the ElasticSearch domain. Creates own KMS key for use in the ES Domain and Cloudwatch Log Groups | `bool` | `true` | no |
| es\_internal\_user\_database\_enabled | Whether the internal user database is enabled. Defaults to `false` | `bool` | `false` | no |
| es\_master\_user\_arn | ARN for the master user. Has no effect if `es_internal_user_database_enabled` is set to `true` | `string` | `null` | no |
| es\_master\_user\_name | The master user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `es_internal_user_database_enabled` is set to `true` | `string` | `null` | no |
| es\_master\_user\_password | The master user's password, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `es_internal_user_database_enabled` is set to `true` | `string` | `null` | no |
| es\_subnet\_ids | A List of subnet ids to associate with the ElasticSearch domain. | `list(string)` | `[]` | no |
| es\_version | The version of Elasticsearch to provision | `string` | `"7.9"` | no |
| es\_vpc\_enabled | Controls if the ElasticSearch Domain should bind to a VPC. If `false` cluster is provisioned outside a VPC | `bool` | `true` | no |
| es\_vpc\_id | The ID of the VPC to configure the ElasticSearch domain with | `string` | `""` | no |
| log\_audit\_enabled | Enables the `AUDIT_LOGS` to CloudWatch. Requires `es_advanced_security_options_enabled` to be enabled | `bool` | `true` | no |
| log\_es\_app\_enabled | Enables the `ES_APPLICATION_LOGS` to CloudWatch | `bool` | `true` | no |
| log\_index\_slow\_enabled | Enables the `INDEX_SLOW_LOGS` to CloudWatch | `bool` | `true` | no |
| log\_publishing\_rentention\_in\_days | Controls the rentation period in days the CloudWatch Log Group applies to published logs | `number` | `30` | no |
| log\_search\_slow\_enabled | Enables the `SEARCH_SLOW_LOGS` to CloudWatch | `bool` | `true` | no |
| security\_groups\_ingress\_source | List of security Group IDs allowed access to the cluster | `list(string)` | `[]` | no |
| tags | Tags to apply to all resources | `map(any)` | `{}` | no |
| tls\_security\_policy\_for\_es\_domain\_endpoint | The name of the TLS security policy that needs to be applied to the HTTPS endpoint. Valid values: `Policy-Min-TLS-1-0-2019-07`(default) and `Policy-Min-TLS-1-2-2019-07`. | `string` | `"Policy-Min-TLS-1-0-2019-07"` | no |
| use\_all\_azs\_in\_region | Defaults to use all availabile Availability Zones in the Region. Takes prescendence over `es_az_count`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| es\_cloudwatch\_log\_group\_arn | The ARN of the Cloudwatch Log Group where ES Domain cluster logs are published |
| es\_cloudwatch\_log\_group\_name | The Name of the Cloudwatch Log Group where ES Domain cluster logs are published |
| es\_domain\_arn | The ARN of the Elastic Search domain. |
| es\_domain\_id | Unique identifier for the Elastic Search domain |
| es\_domain\_name | The name of the Elasticsearch domain |
| es\_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| es\_kibana\_endpoint | The Elastic Search Domain-specific endpoint for Kibana |
| es\_kms\_key\_arn | The ARN of the key used to encrypt data at rest |
| es\_kms\_key\_id | The globally unique identifier for the key used to encrypt data at rest |
| es\_vpc\_security\_group\_arn | The ARN of the security group configured for the Elastic Search Domain |
| es\_vpc\_security\_group\_id | The ID of the security group configured for the Elastic Search Domain |
| es\_vpc\_security\_group\_name | The Name of the security group configured for the Elastic Search Domain |

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```
Copyright 2020 Hypr NZ

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

Copyright &copy; 2020 [Hypr NZ](https://www.hypr.nz/)
