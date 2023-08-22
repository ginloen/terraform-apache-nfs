resource "aws_security_group" "default" {
  name = "terraform_security_group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nfs_server"{
      ami = var.ami_id      
      instance_type = var.instance_type
      vpc_security_group_ids = [aws_security_group.default.id]
      key_name = var.key_name
      tags = {
            app = var.tagvalue
      }
}

resource "aws_instance" "apache_http_server"{
      ami = var.ami_id
      instance_type = var.instance_type
      vpc_security_group_ids = [aws_security_group.default.id]
      key_name = var.key_name
      tags = {
            app = var.tagvalue
      }
}

output "nfs-public-ip"{
       value = aws_instance.nfs_server.public_ip
}

output "apache-public-ip"{
       value = "http://${aws_instance.apache_http_server.public_dns}"
}
