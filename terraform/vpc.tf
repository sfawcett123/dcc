resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = merge( var.tags , { "Name"  = "Database" } )
}

resource "aws_subnet" "database_1" {
  vpc_id     = aws_vpc.main.id

  cidr_block       = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = merge( var.tags , { "Name"  = "db-subnet-1" } )
}

resource "aws_subnet" "database_2" {
  vpc_id     = aws_vpc.main.id

  cidr_block       = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = merge( var.tags , { "Name"  = "db-subnet-2" } )
}

resource "aws_subnet" "database_3" {
  vpc_id     = aws_vpc.main.id

  cidr_block       = "10.0.3.0/24"
  availability_zone = "eu-west-2c"

  tags = merge( var.tags , { "Name"  = "db-subnet-3" } )
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.database_1.id , aws_subnet.database_2.id , aws_subnet.database_3.id]

  tags = merge( var.tags , { "Name"  = "Database" } )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.tags , { "Name"  = "Database" } )
}

data "aws_route_table" "selected" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "route" {
  route_table_id = data.aws_route_table.selected.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id

}
