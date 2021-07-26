variable "name" {
  type    = string
  default = "gatus"
}

variable "image" {
  type    = string
  default = "twinproduction/gatus:v2.7.0"
}

variable "configuration_file_content" {
  type = string
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "memory_requested" {
  type    = string
  default = "40M"
}

variable "memory_limit" {
  type    = string
  default = "100M"
}

variable "cpu_requested" {
  type    = string
  default = "30m"
}

variable "cpu_limit" {
  type    = string
  default = "250m"
}

variable "ingress_host" {
  default     = ""
  type        = string
  description = "Ingress host through which Gatus will be exposed. Not created if blank."
}

variable "node_selector" {
  type    = map(string)
  default = {}
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}
