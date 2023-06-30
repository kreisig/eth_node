terraform {
  required_version = "~> 1.5.2"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  # Add your access token here
  token = "YOUR_TOKEN_HERE"
}

resource "digitalocean_droplet" "droplet" {
  image  = "ubuntu-20-04-x64"
  name   = "eth-node"
  region = "nyc1"
  size   = "s-8vcpu-32gb"
  ssh_keys = [
    # Add your SSH key ID or fingerprint here
    "YOUR_KEY_ID_HERE"
  ]
  user_data = <<-EOT
    #!/bin/bash
    mkfs.ext4 /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01
    mkdir -p /mnt/volume-nyc1-01
    mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01
    echo /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01 ext4 defaults,nofail,discard 0 0 | tee -a /etc/fstab
  EOT
}

resource "digitalocean_volume" "volume" {
  region      = "nyc1"
  name        = "volume-nyc1-01"
  size        = 2000
  description = "Block store for nyc1 droplet"
}

resource "digitalocean_volume_attachment" "volume_attachment" {
  droplet_id = digitalocean_droplet.droplet.id
  volume_id  = digitalocean_volume.volume.id
}

