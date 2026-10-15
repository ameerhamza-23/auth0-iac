resource "auth0_log_stream" "this" {
  name        = var.name
  type        = var.type
  status      = var.status
  is_priority = var.is_priority
  filters     = var.filters

  dynamic "pii_config" {
    for_each = var.pii_config != null ? [var.pii_config] : []
    content {
      log_fields = pii_config.value.log_fields
      method     = pii_config.value.method
      algorithm  = pii_config.value.algorithm
    }
  }

  sink {
    aws_account_id = var.sink.aws_account_id
    aws_region     = var.sink.aws_region

    azure_subscription_id = var.sink.azure_subscription_id
    azure_region          = var.sink.azure_region
    azure_resource_group  = var.sink.azure_resource_group

    http_endpoint       = var.sink.http_endpoint
    http_content_format = var.sink.http_content_format
    http_content_type   = var.sink.http_content_type
    http_custom_headers = var.sink.http_custom_headers
    http_authorization  = var.sink_secrets.http_authorization

    datadog_region             = var.sink.datadog_region
    datadog_api_key_wo         = var.sink_secrets.datadog_api_key
    datadog_api_key_wo_version = var.datadog_api_key_version

    splunk_domain = var.sink.splunk_domain
    splunk_port   = var.sink.splunk_port
    splunk_secure = var.sink.splunk_secure
    splunk_token  = var.sink_secrets.splunk_token

    sumo_source_address = var.sink.sumo_source_address

    segment_write_key = var.sink_secrets.segment_write_key

    mixpanel_project_id               = var.sink.mixpanel_project_id
    mixpanel_region                   = var.sink.mixpanel_region
    mixpanel_service_account_username = var.sink.mixpanel_service_account_username
    mixpanel_service_account_password = var.sink_secrets.mixpanel_service_account_password
  }
}
