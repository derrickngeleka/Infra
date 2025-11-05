source "azure-arm" "vm" {
  use_azure_cli_auth = true

  # Use existing build RG (do NOT set 'location' here)
  build_resource_group_name = var.build_resource_group

  # Base marketplace image (Ubuntu 22.04 LTS Gen2)
  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"

  vm_size      = "Standard_B2s"
  communicator = "ssh"
  ssh_username = "packer"

  # Final artifact: Azure Compute Gallery
  shared_image_gallery_destination {
    resource_group       = var.gallery_resource_group
    gallery_name         = var.gallery_name
    image_name           = var.image_name
    image_version        = var.image_version
    replication_regions  = var.replication_regions
    storage_account_type = "Standard_LRS"
  }
}
