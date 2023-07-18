# Google Cloud Platform Service Account Terraform module
A Terraform module which helps you configure a Google Cloud Platform Service Account, and optional GKE Workload Identity.
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

## Example
```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.63.1 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | ID of the app, lowercase, max 30 chars. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name of the app. | `string` | n/a | yes |
| <a name="input_kubernetes_namespace"></a> [kubernetes\_namespace](#input\_kubernetes\_namespace) | Kubernetes namespace that hosts the Kubernetes Service Account attached to this Google Service Account. | `string` | `null` | no |
| <a name="input_kubernetes_service_account_name"></a> [kubernetes\_service\_account\_name](#input\_kubernetes\_service\_account\_name) | Name of the Kubernetes Service Account to attach to this Google Service Account. | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Google Project ID. | `string` | n/a | yes |
| <a name="input_project_iam_member_roles"></a> [project\_iam\_member\_roles](#input\_project\_iam\_member\_roles) | List of project IAM member roles to attach to the Service Account. | <pre>list(object({<br>    role    = string<br>    project = string<br>    conditions = optional(list(object({<br>      expression  = string<br>      title       = string<br>      description = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_storage_bucket_iam_members"></a> [storage\_bucket\_iam\_members](#input\_storage\_bucket\_iam\_members) | List of Storage bucket IAM member roles to attach to the Service Account. | <pre>list(object({<br>    role   = string<br>    bucket = string<br>    conditions = optional(list(object({<br>      expression  = string<br>      title       = string<br>      description = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_workload_identity_user"></a> [workload\_identity\_user](#input\_workload\_identity\_user) | Wether to attach the roles/iam.workloadIdentityUser Service Account IAM member to the Google Service Account | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The created Google Service Account. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)