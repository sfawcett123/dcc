data "aws_secretsmanager_secret" "db" {
  name = "development/database"
}


data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}
