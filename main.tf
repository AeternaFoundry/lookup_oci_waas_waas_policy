data "oci_waas_waas_policy" "waas_waas_policy_lookup" {
  for_each = var.waas_waas_policy_lookup

  waas_policy_id = each.value.waas_policy_id
}

