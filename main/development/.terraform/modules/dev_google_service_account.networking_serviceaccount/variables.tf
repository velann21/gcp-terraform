# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The name of the GCP Project where all resources will be launched."
  type        = string
}

variable "name" {
  description = "The name of the custom service account. This parameter is limited to a maximum of 28 characters."
  type        = string
}

variable "service_account_roles" {
  description = "Roles to be added to the service account."
  type        = list(string)
  default     = []
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "The description of the custom service account."
  type        = string
  default     = ""
}
