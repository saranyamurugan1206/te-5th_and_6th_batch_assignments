terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket1-project1"
    key          = "terraform-project-1/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
 