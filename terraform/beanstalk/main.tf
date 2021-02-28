# define provider
provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "artifact" {
  bucket = "pos-senai-2021-beanstalk-artifacts"
}

resource "aws_s3_bucket_object" "artifact_object" {
  bucket = aws_s3_bucket.artifact.id
  key    = "php.zip"
  source = "../../files/php.zip"
}

resource "aws_elastic_beanstalk_application" "application" {
  name        = "pos-graduacao-app"

  appversion_lifecycle {
    service_role          = "AWSServiceRoleForElasticBeanstalk"
    max_count             = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = "pos-graduacao-environment"
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2 v3.1.5 running PHP 7.2"
}

resource "aws_elastic_beanstalk_application_version" "pos_php_app" {
  name        = "pos_php_app"
  application = aws_elastic_beanstalk_application.application.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.artifact.id
  key         = aws_s3_bucket_object.artifact_object.id
}