# Template Repo for Terraform Modules

This repo provides a template for creating Terraform Modules. For information on how to create a repo from this template see the [GitHub docs](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template)

## Contents
This repo contains,

1. An Apache 2.0 default license with a copyright statement under Hypr
1. Default .gitignore
1. Default .gitattributes which provides line ending consistency across OS's

## Naming convention

Follow this naming convention for Terraform Module repo's

Terraform-{provider}-{resource-name}-module

Where
 * provider is the cloud provider of the resource (e.g. `aws`, `azure`, `gcp`, `github`)
 * resource-name is the name of the resource
 
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

Please read the [ADRs](docs/architecture/decisions/README.md) for this module to
understand the important architectural decisions that have been made.

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
