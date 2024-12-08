module "service_account" {
  for_each = tomap({
    "db-instance-sa" : ["roles/storage.objectViewer", "roles/storage.objectCreator"],
    "cloud-run" : ["roles/editor"], // TODO: Change this to the appropriate role
    "cloud-build" : [
      "roles/cloudbuild.builds.builder",
      "roles/artifactregistry.writer",
      "roles/run.admin",
      "roles/iam.serviceAccountUser",
    ],
  })

  source     = "./modules/service_account"
  project_id = var.project_id
  account_id = each.key
  roles      = each.value
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "instance" {
  source          = "./modules/instance"
  network         = module.network.network_link
  subnet          = module.network.subnet_link
  service_account = module.service_account["db-instance-sa"].email
}

module "storage" {
  source   = "./modules/storage"
  location = var.region
}

module "tutortoise_registry" {
  source        = "./modules/registry"
  repository_id = "tutortoise"
  description   = "Tutortoise's Artifact Registry"
  location      = var.region
}

module "cloud_build" {
  source             = "./modules/cloud_build"
  service_account_id = module.service_account["cloud-build"].id
}