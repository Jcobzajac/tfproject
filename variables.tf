################################ COMPONENTS ################################

variable "region" {
  description = "The Azure Region"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "managed_identity_name" {
  description = "The name of the Managed Identity"
  type        = string
}

variable "managed_identity_resource_group" {
  description = "The name of the Resource Group of the Managed Identity"
  type        = string
}

variable "cosmosdb_name" {
  description = "The name of the Container App Environment"
  type        = string
}

variable "cosmosdb_resource_group" {
  description = "The name of the Container App Environment"
  type        = string
}

variable "analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace"
  type        = string
}

variable "log_analytics_sku" {
  description = "The SKU of the Log Analytics Workspace"
  type        = string
  default = "PerGB2018"
}

variable "log_analytics_sku_retention_in_day" {
  description = "The workspace data retention in days in the Log Analytics Workspace"
  type        = string
  default = "30"
}

variable "container_app_environment_name" {
  description = "The name of the Container App Environment"
  type        = string
}

variable "dapr_configurations" {
  description = "THE DAPR configuration for the applications"
  type        = map(object({
    app_id   = string
    app_port = number
  }))
  default     = {}
}

################################ BACKEND ################################

variable "backend_container_app_name" {
  description = "The name of the backend application"
  type        = string
}

variable "backend_revision_mode" {
  description = "The revision mode of the backend application"
  type        = string
}

variable "acr_server" {
  description = "The name of the ACR server"
  type        = string
}

variable "backend_image_name" {
  description = "The name of the ACR image"
  type        = string
}

variable "backend_cpu" {
  description = "The amount of the CPU allocated for the backend application"
  type        = number
}

variable "backend_memory" {
  description = "The amount of the memory allocated for the backend application"
  type        = string
} 

variable "is_backed_external" {
  description = "Is the backend application deployed externally?"
  type        = bool
  default = false
} 

variable "backend_target_port" {
  description = "The app port of the backend application"
  type        = number
} 

variable "backend_latest_revision" {
  description = "Is the latest revision enabled on the backend application?"
  type        = bool
  default = true
} 

variable "backend_traffic_percentage_revision" {
  description = "The number of the traffic routed to the revision (%)"
  type        = number
  default = 100
}

################################ FRONTEND ################################

variable "frontend_container_app_name" {
  description = "The name of the frontend application"
  type        = string
}

variable "frontend_revision_mode" {
  description = "The revision mode of the frontend application"
  type        = string
}

variable "frontend_image_name" {
  description = "The name of the ACR image"
  type        = string
}

variable "frontend_target_port" {
  description = "The app port of the frontend application"
  type        = string
}

variable "frontend_cpu" {
  description = "The amount of the CPU allocated for the frontend application"
  type        = number
}

variable "frontend_memory" {
  description = "The amount of the memory allocated for the frontend application"
  type        = string
} 

variable "frontend_latest_revision" {
  description = "Is the latest revision enabled on the frontend application?"
  type        = bool
} 

variable "frontend_traffic_percentage_revision" {
  description = "The number of the traffic routed to the revision (%)"
  type        = number
} 


################################ SSL Certificate ################################

variable "subdomain" {
  description = "The name of the subdomain"
  type        = string
} 

variable "zone_name" {
  description = "The name of the zone"
  type        = string
} 

variable "zone_resource_group" {
  description = "The resource group of the zone"
  type        = string
} 

variable "ttl" {
  description = "The TTL (Time To Live) for the records"
  type        = number
  default = 300
} 
