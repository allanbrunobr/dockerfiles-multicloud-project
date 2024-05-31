resource "//cloudresourcemanager.googleapis.com/projects/app-springboot-project" {
  roles = [
    "roles/compute.instanceAdmin.v1",
    "roles/iam.serviceAccountUser",
    "roles/appengine.appAdmin",
    "roles/cloudbuild.builds.builder",
    "roles/cloudkms.admin",
    "roles/cloudtranslate.admin",
    "roles/visionai.serviceAgent",
    "roles/pubsub.admin",
    "roles/iam.securityAdmin",
    "roles/viewer",
  ]
}