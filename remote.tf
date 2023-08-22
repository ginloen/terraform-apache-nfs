resource "null_resource" "remote_nfs_server"{
connection {
       type = "ssh"
       user = "ubuntu"
       private_key = var.ec2_private_key
       host  = aws_instance.nfs_server.public_ip
}
provisioner "remote-exec" {
         inline = [
                       "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
                       "sudo apt-get update",
                       "sudo apt-get install nfs-kernel-server -y",
                       "sudo mkdir /mnt/public-shared -p",
                       "sudo chown nobody:nogroup /mnt/public-shared",
                       "echo '/mnt/public-shared    ${aws_instance.apache_http_server.public_ip}(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports",
                       "sudo systemctl restart nfs-kernel-server"
                  ]
  }
}

resource "null_resource" "remote_apache_http_server"{
connection {
       type = "ssh"
       user = "ubuntu"
       private_key = var.ec2_private_key
       host  = aws_instance.apache_http_server.public_ip
}
depends_on = [null_resource.remote_nfs_server]
provisioner "remote-exec" {
         inline = [
                       "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
                       "sudo apt-get update",
                       "sudo apt-get install nfs-common -y",
                       "sudo apt-get install apache2 -y",
                       "sudo mkdir -p /var/www/html/web",
                       "echo '${aws_instance.nfs_server.public_ip}:/mnt/public-shared    /var/www/html/web    nfs    defaults' | sudo tee -a /etc/fstab",
                       "sudo mount ${aws_instance.nfs_server.public_ip}:/mnt/public-shared    /var/www/html/web"
                  ]
  }
}

