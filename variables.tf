variable "account_id" {
  type        = string
  description = "ID of the app, lowercase, max 30 chars."
}

variable "display_name" {
  type        = string
  description = "Display name of the app."
}

variable "project" {
  type        = string
  description = "Google Project ID."
}

variable "description" {
  type        = string
  nullable    = true
  default     = null
  description = "(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
}

variable "project_iam_member_roles" {
  type = list(object({
    role    = string
    project = string
    conditions = optional(list(object({
      expression  = string
      title       = string
      description = optional(string)
    })))
  }))
  default     = []
  description = "List of project IAM member roles to attach to the Service Account."
}

variable "storage_bucket_iam_members" {
  type = list(object({
    role   = string
    bucket = string
    conditions = optional(list(object({
      expression  = string
      title       = string
      description = optional(string)
    })))
  }))
  default     = []
  description = "List of Storage bucket IAM member roles to attach to the Service Account."
}

variable "workload_identity_user" {
  type        = bool
  default     = false
  description = "Wether to attach the roles/iam.workloadIdentityUser Service Account IAM member to the Google Service Account"
}

variable "kubernetes_namespace" {
  type        = string
  default     = null
  description = "Kubernetes namespace that hosts the Kubernetes Service Account attached to this Google Service Account."
}

variable "kubernetes_service_account_name" {
  type        = string
  default     = null
  description = "Name of the Kubernetes Service Account to attach to this Google Service Account."
}
