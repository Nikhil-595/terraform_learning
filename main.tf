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

resource "github_repository" "iac-github-02" {
  name        = "iac-github-02"
  description = "this github repo was created and managed using terraform"
  auto_init = true
  #private = false
  visibility = "public"
  archive_on_destroy = true

}

resource "github_branch" "dev" {
  repository = "iac-github-02"
  branch     = "dev"
  source_branch = "master"

  depends_on = [
    github_repository.iac-github-02
  ]
}

resource "github_branch_protection" "nalinture" {
  repository_id  = github_repository.iac-github-02.name
  pattern       = "main"
  pattern       = "dev"
  // allows_deletions = true

}

resource "github_repository_file" "iac-github-02" {
repository          = github_repository.iac-github-02.name
branch              = "master"
file                = ".gitignore"
content             = "**/*.tfstate"
commit_message      = "Managed by github.com/nalinture/terraform_learning"
commit_author       = "Terraform User"
commit_email        = "nalinkumarmurugesan@gmail.com"
overwrite_on_create = true

  depends_on = [
    github_repository.iac-github-02
  ]


}
