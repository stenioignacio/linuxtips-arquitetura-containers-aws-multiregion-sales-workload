project_name = "sales-workload"
region       = "sa-east-1"

sqs_processing_sales_config = {
  queue_name                    = "sales-processing"
  delay_seconds                 = 0
  max_message_size              = 262144
  message_retention_seconds     = 86400
  receive_wait_time_seconds     = 10
  visibility_timeout_seconds    = 60
  dlq_redrive_max_receive_count = 4
}

bucket_prefix_name = "sales-offload-datalake"

sales_idempotency_table_name = "sales-workload"
sales_table_name             = "sales-workload-idempotency"
parameter_store_state_name   = "/sales/site/state"

ssm_vpc_id           = "/linuxtips-multiregion/vpc/vpc_id"
ssm_private_subnet_1 = "/linuxtips-multiregion/vpc/private/sa-east-1a"
ssm_private_subnet_2 = "/linuxtips-multiregion/vpc/private/sa-east-1b"
ssm_private_subnet_3 = "/linuxtips-multiregion/vpc/private/sa-east-1c"
ssm_alb              = "/sales-cluster/lb/internal/arn"
ssm_listener         = "/sales-cluster/lb/internal/listener/arn"

cluster_name = "ecs-cluster-sales-cluster"
