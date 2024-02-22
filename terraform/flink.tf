resource "confluent_flink_compute_pool" "compute_pool_1" {
  display_name     = "${var.resource_prefix}compute_pool_1"
  cloud            = var.cloud_provider
  region           = var.cloud_region
  max_cfu          = 5
  environment {
    id = confluent_environment.cc_env.id
  }
}