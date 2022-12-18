# AWS XXX Terraform module (template)

Terraform module template for AWS resources.

## Usage
```hcl
module "_module_template" {
  source = "${path.module}/../modules/_module_template"

  name_prefix = "demo"
}
```
