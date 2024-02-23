resource "confluent_connector" "fleet_mgmt_description_source" {
  environment {
    id = confluent_environment.cc_env.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.basic.id
  }

  config_sensitive = {}

  config_nonsensitive = {
    "connector.class"    = "DatagenSource"
    "name"               = "Datagen_FleetMgmtDescription"
    "kafka.auth.mode"    = "KAFKA_API_KEY"
    "kafka.api.key"      = confluent_api_key.app-manager-kafka-api-key.id
    "kafka.api.secret"   = confluent_api_key.app-manager-kafka-api-key.secret
    "kafka.topic"        = confluent_kafka_topic.fleet_mgmt_description.topic_name
    "output.data.format" = "AVRO"
    "quickstart"         = "FLEET_MGMT_DESCRIPTION"
    "schema.keyfield"    = "vehicle_id"
    "tasks.max"          = "1"
  }

  depends_on = []

  lifecycle {
    prevent_destroy = false
  }
}