# terraform-kubernetes-gatus
For documentation on Gatus, see [TwinProduction/gatus](https://github.com/TwinProduction/gatus).

[View Terraform Registry documentation for TwinProduction/gatus/kubernetes](https://registry.terraform.io/modules/TwinProduction/gatus/kubernetes)

## Usage
```hcl
module "gatus" {
  source                     = "TwinProduction/gatus/kubernetes"
  configuration_file_content = file("${path.module}/files/gatus.yaml")
}
```

| Variable                   | Description                              | Default value                 |
|:-------------------------- |:---------------------------------------- |:----------------------------- |
| name                       | Name to use for resources                | `gatus`                       | 
| namespace                  | Namespace in which Gatus will be running | `kube-system`                 |
| image                      | Image to use for the container           | `twinproduction/gatus:v2.7.0` |
| configuration_file_content | Gatus configuration. See [TwinProduction/gatus](https://github.com/TwinProduction/gatus). | `""` Required |
| ingress_host               | Ingress host through which Gatus will be exposed. Not created if blank.  | `""` |
| memory_request             | Memory request                           | `40M`                         |                                                                                                  
| memory_limit               | Memory limit                             | `100M`                        |
| cpu_request                | CPU request                              | `30m`                         |
| cpu_limit                  | CPU limit                                | `250m`                        |
| node_selector              | Node selectors to use for pods.          | `{}`                          |
| environment_variables      | Extra environment variables to pass to the container in which Gatus is running. Used for configuration purposes. | `{}` |
