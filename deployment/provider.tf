provider "aws" {
  region                   = var.region
  profile                  = "lab"
  shared_config_files      = ["C:\\Users\\signacio\\.aws\\config"]
  shared_credentials_files = ["C:\\Users\\signacio\\.aws\\credentials"]

  default_tags {
    tags = {
      Name = "workload-projeto-final-arq-containers"
    }
  }
}
