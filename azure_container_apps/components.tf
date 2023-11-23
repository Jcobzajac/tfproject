resource "azurerm_resource_group" "resource_group" {
  name     = "${var.project_name}-${var.resource_group_name}"
  location = var.region
}

data "azurerm_user_assigned_identity" "identity" {
  name                = var.managed_identity_name 
  resource_group_name = var.managed_identity_resource_group 
}

resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                = "${var.project_name}-${var.analytics_workspace_name}"
  location            = var.region
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_sku_retention_in_day

}

resource "azurerm_container_app_environment" "container_app_environment" {
  name                       = "${var.project_name}-${var.container_app_environment_name}"
  location                   = azurerm_resource_group.resource_group.location
  resource_group_name        = azurerm_resource_group.resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.analytics_workspace.id
}

resource "null_resource" "create_dapr_component" {
  
   provisioner "local-exec" {
    command    = "./azure_container_apps/deploy_dapr_component.sh ${var.cosmosdb_name} ${var.cosmosdb_resource_group} ${azurerm_resource_group.resource_group.name} ${azurerm_container_app_environment.container_app_environment.name}"
    on_failure = continue
  }

  lifecycle {
    replace_triggered_by = [azurerm_container_app_environment.container_app_environment]
  }
  
  depends_on = [azurerm_container_app_environment.container_app_environment]
}