output "rds-read-replica-endpoint" {
  value = aws_db_instance.SnapVibe-rds-read-replica.endpoint
}

output "rds-write-endpoint" {
  value = aws_db_instance.SnapVibe-rds.endpoint
}