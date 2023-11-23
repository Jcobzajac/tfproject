region = "UK South"
project_name  = "acaproject"
resource_group_name = "rg-namee"
analytics_workspace_name = "law-name"
container_app_environment_name = "cae-namee"
managed_identity_name = "AKSSUKDEVAKS235-identity"
managed_identity_resource_group = "RGPSUKDEVAKS235"
backend_container_app_name = "backend"
cosmosdb_name = "acaproject"
cosmosdb_resource_group = "RGPSUKDEVAKS235"
acr_server = "acaproject.azurecr.io"
backend_revision_mode = "Single"
backend_image_name = "acaproject.azurecr.io/backend:1.1"
backend_cpu = 0.5
backend_memory = "1Gi"
backend_target_port = 5000
frontend_container_app_name = "frontend"
frontend_revision_mode = "Single"
frontend_image_name = "acaproject.azurecr.io/frontend:1.0"
frontend_cpu = 0.5
frontend_memory  = "1Gi"
frontend_target_port = 5000
frontend_latest_revision = true
frontend_traffic_percentage_revision = 100
subdomain = "mailbase"
zone_name = "intoglobal.dev"
zone_resource_group = "rgpneutstpdns01"
dapr_configurations = {
backend = {
    app_id   = "backend"
    app_port = 5000
},
frontend = {
    app_id   = "frontend"
    app_port = 5000
},
}
