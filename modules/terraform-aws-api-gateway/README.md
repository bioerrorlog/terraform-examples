# API Gateway module

Terraform module template for AWS resources.

## Usage
```hcl
module "_module_template" {
  source = "${path.module}/../modules/terraform-aws-api-gateway"

  name_prefix = "demo"
}
```
