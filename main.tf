module "db-instance-sa" {
  source     = "./modules/service_account"
  account_id = "db-instance-sa"
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "instance" {
  source          = "./modules/instance"
  network         = module.network.network_link
  subnet          = module.network.subnet_link
  zone            = var.zone
  service_account = module.db-instance-sa.email
}

module "storage" {
  source   = "./modules/storage"
  location = var.region
}
