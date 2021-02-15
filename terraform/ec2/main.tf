# define provider
provider "aws" {
  region = var.aws_region
}

#create SG for instance
resource "aws_security_group" "web" {
  name        = "pos-graduacao-sg-public"
  description = "Allow Public Traffic to Instance"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pos-graduacao-sg-public"
  }
}

resource "tls_private_key" "ubuntu_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ubuntu_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ubuntu_key.public_key_openssh
}

# get latest ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# create ec2 instance for python-app
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_type
  #iam_instance_profile   = aws_iam_instance_profile.iam_s3_profile.name
  key_name               = aws_key_pair.ubuntu_key.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = var.instance_name
  }
}

# publish app on ec2-instance
resource "null_resource" "connect_to_ec2" {

  provisioner "file" {
    source      = "../../files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "file" {
    source      = "../../scripts/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.ubuntu_key.private_key_pem
    host        = aws_instance.web.public_ip
  }
  #depends_on = ["aws_instance.public_ip"]
}