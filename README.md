# terraform-kubernetes-gatus
For documentation on Gatus, see [TwinProduction/gatus](https://github.com/TwinProduction/gatus).


## Usage
```hcl-terraform
module "gatus" {
  configuration_file_content = file("${path.module}/files/gatus.yaml")
}
```
