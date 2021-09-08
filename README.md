This is a template repo, you will need to update:

- [ ] Update links in the contributing.md
- [ ] Links in the readme.md
- [ ] Headings in the readme.md
- [ ] The readme.md content
- [ ] Link at the top of .releaserc
- [ ] Add at least a completed example in the examples folder

Notes:
- Pipeline should just work out of the box when .releaserc is updated
- Terraform docs will populate the inputs and outputs during pipeline run 
- Delete these sections when finished 

# terraform-aws-template [![Build Status](https://github.com/and-digital/terraform-aws-template/workflows/build/badge.svg)](https://github.com/and-digital/terraform-aws-template/actions)

> A terraform module for creating AWS template resources.

## Table of Contents

- [Maintenance](#maintenance)
- [Getting Started](#getting-started)
- [License](#license)

## Maintenance

This project is maintained [AND Digital](https://github.com/and-digital), anyone is welcome to contribute.

## Getting Started

#### Example

```
module "template" {
  source = "../../"

  an example

```

<!--- BEGIN_TF_DOCS --->
## Providers

No provider.

## Inputs

No input.

## Outputs

No output.
<!--- END_TF_DOCS --->

## License

Apache 2 Licensed. See [HERE](https://github.com/and-digital/terraform-aws-template/tree/master/LICENSE) for full details.