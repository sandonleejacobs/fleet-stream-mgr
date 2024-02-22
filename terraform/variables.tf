variable "cloud_provider" {
  type = string
  description = "cloud provider for Confluent Cloud"
  default = "AWS"
}

variable "cloud_region" {
  type = string
  description = "cloud provider region"
  default = "us-east-2"
}

variable "cc_prevent_destroy" {
  type = bool
  description = "protect from tf destroy command"
  default = true
}

variable "cc_env_display_name" {
  type = string
  description = "Name of Confluent Cloud Environment to Manage"
  default = "fleet-stream-mgr"
}

variable "cc_cluster_1_name" {
  type = string
  description = "name of kafka cluster"
  default = "cluster-1"
}