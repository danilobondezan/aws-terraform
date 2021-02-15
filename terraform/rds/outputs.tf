output "rds_database_endpoint" {
  value = aws_db_instance.database.address
}