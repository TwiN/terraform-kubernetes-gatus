variable "name" {
  type    = string
  default = "gatus"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "image" {
  type    = string
  default = "twinproduction/gatus:v5.11.0"
}

variable "configuration_file_content" {
  type        = string
  description = "Content of the Gatus configuration file. Try using something like file(\"$${path.module}/files/gatus.yaml\")"
}

variable "ingress_host" {
  type        = string
  default     = ""
  description = "Ingress host through which Gatus will be exposed. Not created if blank."
}

variable "ingress_annotations" {
  type    = map(string)
  default = {}
}

variable "ingress_tls_secret_name" {
  type        = string
  default     = ""
  description = "Secret name to use for TLS"
}

variable "memory_request" {
  type    = string
  default = "40M"
}

variable "memory_limit" {
  type    = string
  default = "100M"
}

variable "cpu_request" {
  type    = string
  default = "30m"
}

variable "cpu_limit" {
  type    = string
  default = "250m"
}

variable "node_selector" {
  type    = map(string)
  default = {}
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}
