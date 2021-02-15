# define provider
provider "aws" {
  region = var.aws_region
}

#create SG for instance
resource "aws_security_group" "database" {
  name        = "pos-graduacao-db-sg-public"
  description = "Allow Public Traffic to Instance"

  ingress {
    description = "Allow Mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["189.34.12.101/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pos-graduacao-db-sg-public"
  }
}

resource "aws_db_instance" "database" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_instance_name
  username             = "possenai"
  password             = "posgraduacao2021"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  vpc_security_group_ids = ["${aws_security_group.database.id}"]
}