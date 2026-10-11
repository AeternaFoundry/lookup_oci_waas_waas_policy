variable "waas_waas_policy_lookup" {
  description = <<EOT
Map of waas_waas_policy_lookup, attributes below
Required:
    - waas_policy_id
EOT

  type = map(object({
    waas_policy_id = string
  }))
  validation {
    condition = alltrue([
      for k, v in var.waas_waas_policy_lookup : (
        alltrue([for item in v.policy_config : (item.load_balancing_method == null || alltrue([for item in item.load_balancing_method : (item.method == null || (contains([for v in ["IP_HASH", "ROUND_ROBIN", "STICKY_COOKIE"] : lower(v)], lower(item.method))))]))])
      )
    ])
    error_message = "must be one of: \"IP_HASH\", \"ROUND_ROBIN\", \"STICKY_COOKIE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.waas_waas_policy_lookup : (
        alltrue([for item in v.waf_config : (item.access_rules == null || alltrue([for item in item.access_rules : (item.response_header_manipulation == null || alltrue([for item in item.response_header_manipulation : (item.action == null || (contains([for v in ["ADD_HTTP_RESPONSE_HEADER", "EXTEND_HTTP_RESPONSE_HEADER", "REMOVE_HTTP_RESPONSE_HEADER"] : lower(v)], lower(item.action))))]))]))])
      )
    ])
    error_message = "must be one of: \"ADD_HTTP_RESPONSE_HEADER\", \"EXTEND_HTTP_RESPONSE_HEADER\", \"REMOVE_HTTP_RESPONSE_HEADER\""
  }
}

