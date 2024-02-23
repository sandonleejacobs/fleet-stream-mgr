resource "confluent_kafka_topic" "fleet_mgmt_location" {
  kafka_cluster {
    id = confluent_kafka_cluster.basic.id
  }

  topic_name    = "fleet_mgmt_location"
  rest_endpoint = confluent_kafka_cluster.basic.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }

  partitions_count = 3
  config           = {
    "cleanup.policy" = "delete"
  }
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [
    confluent_schema_registry_cluster.essentials
  ]
}