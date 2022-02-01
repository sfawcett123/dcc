data "aws_secretsmanager_secret" "db" {
  name = "development/database"
}


data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

locals {
 secrets = {
  username = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["password"]
  host = split( ":" , aws_db_instance.database.endpoint)[0] 
  port = split( ":" , aws_db_instance.database.endpoint)[1] 
 }
}

resource "aws_secretsmanager_secret_version" "save" {
  secret_id = data.aws_secretsmanager_secret.db.id
  secret_string = jsonencode( local.secrets )
}
