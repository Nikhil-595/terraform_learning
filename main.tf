/*terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}*/

# Configure the GitHub Provider
provider "github" {
    token = var.github_token
    owner = "nalinture"
}

variable "github_token" {
    default = "cooku_with_comali"
}

resource "github_repository" "iac-github" {
  name        = "iac-github"
  description = "this github repo was created and managed using terraform"
  auto_init = true
  #private = false
  visibility = "public"

}

resource "github_branch" "dev" {
  repository = "iac-github"
  branch     = "dev"
}

resource "github_repository_file" "iac-github" {
 repository          = github_repository.iac-github.name
branch              = "main"
file                = ".gitignore"
content             = "**/*.tfstate"
commit_message      = "Managed by Terraform"
commit_author       = "Terraform User"
commit_email        = "nalinkumarmurugesan@gmail.com"
overwrite_on_create = true
}