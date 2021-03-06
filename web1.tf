resource "digitalocean_droplet" "web1" {
    image = "ubuntu-18-04-x64"
    name = "web1"
    region = "FRA1"
    size = "s-1vcpu-1gb" #Smallest standard droplet
    private_networking = true
    ssh_keys = [
        var.ssh_fingerprint
    ]
    connection {
        user = "root"
        type = "ssh"
        host = self.ipv4_address
        private_key = file(var.pvt_key)
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            #install nginx
            "sudo apt-get update",
            "sudo apt-get -y install nginx"
        ]
    }
}

