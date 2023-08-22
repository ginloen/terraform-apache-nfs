variable "aws_region" {
    description = "Default AWS Region for resources"
    default = "ap-southeast-1"
}

variable "instance_type" {
    description = "Default instance type"
    default = "t2.micro"
}

variable "key_name" {
    description = "Default key pair for EC2"
    default = "terraformhpett"
}

variable "ec2_private_key" {
    description = "Default private key to connect remote EC2"
    default = ""
}

variable "AWS_ACCESS_KEY_ID" {
    description = "AWS access key id"
    default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    description = "AWS access key secret"
    default = ""
}

variable "ami_id" {
    description = "Default Amazon Linux AMI ID"
    default = "ami-002843b0a9e09324a"
}

variable "tagvalue" {
    description = "Default tag value"
    default = "hpett"
}
