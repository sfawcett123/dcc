terraform {
  backend "s3" {
    bucket = "dcc.terraform.s3"
    key    = "development/state/development.tfstate"
    region = "eu-west-2"
  }
}

