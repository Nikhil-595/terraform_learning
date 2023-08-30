terraform {
  backend "remote" {
    organization = "github_iac"

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

resource "github_repository" "repo" {
  name        = "iac-github-14"
  description = "this github repo was created and managed using terraform"
  auto_init = true
  #private = false
  visibility = "public"
  archive_on_destroy = true

}

resource "github_branch" "dev" {
  repository = "iac-github-13"
  branch     = "dev"
  source_branch = "master"

  depends_on = [
    github_repository.repo
  ]
}

resource "github_repository_file" "file" {
repository          = github_repository.repo.name
branch              = "master"
file                = ".txt"
content             = "**/*.tfstate"
commit_message      = "Managed by github.com/nalinture/terraform_learning"
commit_author       = "Terraform User"
commit_email        = "nalinkumarmurugesan@gmail.com"
overwrite_on_create = true

  depends_on = [
    github_repository.repo
  ]


}
