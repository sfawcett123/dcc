#
# Database Defaults
#

variable "engine" {
  default = "mySQL"
}
variable "engine_version" {
  default = "8.0.23"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "name" {
  default = "arduino"
}
variable "parameter_group_name" {
  default = "dcc-pg"
}
variable "parameter_group_family" {
  default = "mysql8.0"
}

#
# Redis Defaults
#


#
# Tags
#
variable "tags" {
  type = map(any)
  default = {
    "ROLE"  = "DCC"
    "OWNER" = "Steven Fawcett"
  }
}
