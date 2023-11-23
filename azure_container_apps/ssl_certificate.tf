resource "azurerm_dns_cname_record" "cname_record" {
  name                = var.subdomain
  zone_name           = var.zone_name
  resource_group_name = var.zone_resource_group
  ttl                 = var.ttl
  record              = azurerm_container_app.frontend.latest_revision_fqdn
}

resource "azurerm_dns_txt_record" "txt_record" {
  name                = "asuid.${var.subdomain}"
  zone_name           = var.zone_name
  resource_group_name =  var.zone_resource_group
  ttl                 = 300

  record {
    value = azurerm_container_app.frontend.custom_domain_verification_id
}
}

resource "null_resource" "provision_managed_certificate" {
  
  provisioner "local-exec" {
    command    = "sleep 5"
    on_failure = continue
  }

  provisioner "local-exec" {
    command    = "az containerapp hostname add --resource-group ${azurerm_resource_group.resource_group.name} --name ${azurerm_container_app.frontend.name} --hostname ${var.subdomain}.${var.zone_name}"
    on_failure = continue
  }

  provisioner "local-exec" {
    command    = "az containerapp hostname bind --resource-group ${azurerm_resource_group.resource_group.name} --name ${azurerm_container_app.frontend.name} --hostname ${var.subdomain}.${var.zone_name} --environment ${azurerm_container_app_environment.container_app_environment.name} --validation-method CNAME"
    on_failure = continue
  }

  lifecycle {
    replace_triggered_by = [azurerm_container_app.frontend]
  }
  depends_on = [ azurerm_dns_cname_record.cname_record, azurerm_dns_txt_record.txt_record ]
}
