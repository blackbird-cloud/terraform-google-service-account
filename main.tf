resource "google_service_account" "sa" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project
  description  = var.description
}

resource "google_project_iam_member" "roles" {
  for_each = {
    for role in var.project_iam_member_roles : "${role.role}-${role.project}" => role
  }

  role    = each.value.role
  project = each.value.project
  member  = google_service_account.sa.member
  dynamic "condition" {
    for_each = each.value.conditions != null ? each.value.conditions : []

    content {
      title       = condition.value.title
      expression  = condition.value.expression
      description = try(condition.value.description, null)
    }
  }
}

resource "google_service_account_iam_member" "roles" {
  for_each = {
    for role in var.service_account_iam_member_roles : "${role.role}-${role.project}" => role
  }

  service_account_id = google_service_account.sa.name
  role               = each.value.role
  member             = each.value.member
}

resource "google_service_account_iam_member" "workload" {
  count = var.workload_identity_user && var.kubernetes_namespace != "" && var.kubernetes_service_account_name != "" ? 1 : 0

  service_account_id = google_service_account.sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project}.svc.id.goog[${var.kubernetes_namespace}/${var.kubernetes_service_account_name}]"
}

resource "google_storage_bucket_iam_member" "default" {
  for_each = {
    for role in var.storage_bucket_iam_members : "${role.bucket}-${role.role}" => role
  }

  role   = each.value.role
  bucket = each.value.bucket
  member = google_service_account.sa.member
  dynamic "condition" {
    for_each = each.value.conditions != null ? each.value.conditions : []

    content {
      title       = condition.value.title
      expression  = condition.value.expression
      description = try(condition.value.description, null)
    }
  }
}

