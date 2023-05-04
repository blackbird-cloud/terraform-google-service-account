resource "google_service_account" "sa" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project
}

resource "google_project_iam_member" "roles" {
  for_each = {
    for role in var.project_iam_member_roles : "${role.role}-${role.project}" => role
  }

  role    = each.value.role
  project = each.value.project
  member  = google_service_account.sa.member
}

resource "google_service_account_iam_member" "workload" {
  count = var.workload_identity_user && var.kubernetes_namespace != "" && var.kubernetes_service_account_name != "" ? 1 : 0

  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.sa.name
  member             = "serviceAccount:${var.project}.svc.id.goog[${var.kubernetes_namespace}/${var.kubernetes_service_account_name}]"
}
