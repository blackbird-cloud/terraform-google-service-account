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

variable "project_iam_member_roles" {
  type        = list(string)
  default     = []
  description = "List of project IAM member roles to attach to the Service Account."
}

variable "workload_identity_user" {
  type        = bool
  default     = false
  description = "Wether to attach the roles/iam.workloadIdentityUser Service Account IAM member to the Google Service Account"
}

variable "kubernetes_namespace" {
  type        = string
  default     = ""
  description = "Kubernetes namespace that hosts the Kubernetes Service Account attached to this Google Service Account."
}

variable "kubernetes_service_account_name" {
  type        = string
  default     = ""
  description = "Name of the Kubernetes Service Account to attach to this Google Service Account."
}
