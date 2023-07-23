terraform {
  backend "remote" {
    organization = "nalinkumar-iac"

    workspaces {
      name = "api-driven"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = var.github_token
    owner = "nalinture"
}

variable "github_token" {
    default = "cooku_with_comali-04"
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
  source_branch = "master"

  depends_on = [
    github_repository.iac-github
  ]
}

resource "github_repository_file" "iac-github" {
repository          = github_repository.iac-github.name
branch              = "master"
file                = ".gitignore"
content             = "**/*.tfstate"
commit_message      = "Managed by Terraform"
commit_author       = "Terraform User"
commit_email        = "nalinkumarmurugesan@gmail.com"
overwrite_on_create = true

  depends_on = [
    github_repository.iac-github
  ]


}
