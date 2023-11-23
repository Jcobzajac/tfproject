resource "azurerm_container_app" "frontend" {
  name                         = var.frontend_container_app_name
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = azurerm_resource_group.resource_group.name
  revision_mode                = var.frontend_revision_mode 

  registry {
    server = var.acr_server 
    identity = data.azurerm_user_assigned_identity.identity.id
  }

  template {
    container {
      name   = var.frontend_container_app_name
      image  = var.frontend_image_name 
      cpu    = var.frontend_cpu 
      memory = var.frontend_memory 
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  }

  ingress {
    external_enabled           = true
    target_port                = var.frontend_target_port 
    traffic_weight {
      latest_revision = var.frontend_latest_revision
      percentage = var.frontend_traffic_percentage_revision
    }
  }

  dynamic "dapr" {
      for_each = var.dapr_configurations["frontend"] != null ? [var.dapr_configurations["frontend"]] : []

      content {
        app_id   = dapr.value.app_id
        app_port = dapr.value.app_port
      }
    }
  
  depends_on = [ azurerm_container_app_environment.container_app_environment ]

}