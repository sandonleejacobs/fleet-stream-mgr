output "cc_env_display_name" {
  value = confluent_environment.cc_env.display_name
}

output "cc_env_id" {
  value = confluent_environment.cc_env.id
}

output "cc_kafka_cluster_1_id" {
  value = confluent_kafka_cluster.basic.id
}

output "cc_kafka_cluster_bootstrap_endpoint" {
  value = confluent_kafka_cluster.basic.bootstrap_endpoint
}

output "cc_kafka_cluster_rest_endpoint" {
  value = confluent_kafka_cluster.basic.rest_endpoint
}

output "cc_schema_registry_id" {
  value = confluent_schema_registry_cluster.essentials.id
}

output "cc_schema_registry_endpoint" {
  value = confluent_schema_registry_cluster.essentials.rest_endpoint
}

output "app_mgr_api_key_id" {
  value = confluent_api_key.app-manager-kafka-api-key.id
  sensitive = true
}

output "app_mgr_api_key_secret" {
  value = confluent_api_key.app-manager-kafka-api-key.secret
  sensitive = true
}

output "env_mgr_sr_api_key_id" {
  value = confluent_api_key.env-manager-schema-registry-api-key.id
  sensitive = true
}

output "env_mgr_sr_api_key_secret" {
  value = confluent_api_key.env-manager-schema-registry-api-key.secret
  sensitive = true
}

output "compute_pool_1_id" {
  value = confluent_flink_compute_pool.compute_pool_1.id
}

output "datagen_fleet_mgmt_location_id" {
  value = confluent_connector.fleet_mgmt_location_source.id
}

output "datagen_fleet_mgmt_location_status" {
  value = confluent_connector.fleet_mgmt_location_source.status
}
