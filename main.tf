module "network" {
  source = "./modules/network"
  region = var.region
}

module "instance" {
  source  = "./modules/instance"
  network = module.network.network_link
  subnet  = module.network.subnet_link
  zone    = var.zone
}

module "storage" {
  source   = "./modules/storage"
  location = var.region
}