resource "aws_db_parameter_group" "dbpg" {
  name   = var.parameter_group_name
  family = var.parameter_group_family
  tags   = var.tags
}

resource "aws_db_instance" "database" {
  name                                = var.name
  allocated_storage                   = 20
  auto_minor_version_upgrade          = true
  copy_tags_to_snapshot               = true
  customer_owned_ip_enabled           = false
  delete_automated_backups            = true
  deletion_protection                 = false
  enabled_cloudwatch_logs_exports     = []
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = false
  instance_class                      = var.instance_class
  max_allocated_storage               = 1000
  monitoring_interval                 = 0
  multi_az                            = false
  publicly_accessible                 = true
  storage_encrypted                   = false
  storage_type                        = "gp2"
  username                            = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["username"]
  password                            = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["password"]
  parameter_group_name                = aws_db_parameter_group.dbpg.id
  skip_final_snapshot                 = true
  db_subnet_group_name                = aws_db_subnet_group.default.name

  tags = merge( var.tags , { "Name"  = "Arduino" } )

  depends_on = [aws_internet_gateway.gw]
}

