module "container_apps" {
  source               = "./azure_container_apps"
  region   = var.region
  project_name       = var.project_name 
  resource_group_name = var.resource_group_name
  analytics_workspace_name = var.analytics_workspace_name
  container_app_environment_name = var.container_app_environment_name
  managed_identity_name = var.managed_identity_name
  managed_identity_resource_group = var.managed_identity_resource_group
  cosmosdb_name = var.cosmosdb_name
  cosmosdb_resource_group = var.cosmosdb_resource_group
  backend_container_app_name = var.backend_container_app_name
  acr_server = var.acr_server
  backend_revision_mode = var.backend_revision_mode
  backend_image_name = var.backend_image_name
  backend_cpu = var.backend_cpu
  backend_memory = var.backend_memory
  backend_target_port = var.backend_target_port
  frontend_container_app_name = var.frontend_container_app_name
  frontend_revision_mode = var.frontend_revision_mode
  frontend_image_name = var.frontend_image_name
  frontend_cpu = var.frontend_cpu
  frontend_memory  = var.frontend_memory
  frontend_target_port = var.frontend_target_port
  frontend_latest_revision = var.frontend_latest_revision
  frontend_traffic_percentage_revision = var.frontend_traffic_percentage_revision
  subdomain = var.subdomain
  zone_name = var.zone_name
  zone_resource_group = var.zone_resource_group
  dapr_configurations = var.dapr_configurations

}