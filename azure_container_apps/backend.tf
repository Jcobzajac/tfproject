resource "azurerm_container_app" "backend" {
  name                         = var.backend_container_app_name
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = azurerm_resource_group.resource_group.name
  revision_mode                = var.backend_revision_mode 

  registry {
    server = var.acr_server 
    identity = data.azurerm_user_assigned_identity.identity.id
  }

  template {
    container {
      name   = var.backend_container_app_name
      image  = var.backend_image_name 
      cpu    = var.backend_cpu 
      memory = var.backend_memory 
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  }

  ingress {
    external_enabled           = var.is_backed_external 
    target_port                = var.backend_target_port 
    
    traffic_weight {
      latest_revision = var.backend_latest_revision
      percentage = var.backend_traffic_percentage_revision
    }
  }

  dynamic "dapr" {
      for_each = var.dapr_configurations["backend"] != null ? [var.dapr_configurations["backend"]] : []

      content {
        app_id   = dapr.value.app_id
        app_port = dapr.value.app_port
      }
    }
  
  depends_on = [ azurerm_container_app_environment.container_app_environment ]

}