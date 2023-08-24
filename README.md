# terraform-apache-nfs

**Install terraform**

1. Install gnupg, software-properties-common and curl
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

2. Install HashiCorp GPG key
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

3. Add official HashiCorp repository
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

4. Download package information
```
sudo apt update
```

5. Install terraform
```
sudo apt-get install terraform
```

6. Run terraform login
