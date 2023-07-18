module "service_account" {
  source  = "blackbird-cloud/service-account/google"
  version = "~> 1"

  account_id   = "my-app"
  display_name = "My service account."
  project      = "my-project"

  workload_identity_user          = true
  kubernetes_namespace            = "monitoring"
  kubernetes_service_account_name = "my-app"

  project_iam_member_roles = [
    {
      role    = "roles/pubsub.publisher",
      project = "my-project",
      conditions = [{
        title       = "title"
        description = "description"
        expression  = "my-exp"
      }]
    },
    {
      role    = "roles/datastore.owner",
      project = "my-other-project"
    },
  ]
}
