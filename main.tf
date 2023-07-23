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

locals {
 repos = {
   "repo1" = { name = "iac-github-04" },
   "repo2" = { name = "iac-github-05" },
   "repo3" = { name = "iac-github-06" }
 }
}

resource "github_repository" "repo" {
  for_each = local.repos
  name        = each.value.name
  description = "this github repo was created and managed using terraform"
  auto_init = true
  #private = false
  visibility = "public"
  archive_on_destroy = true

}


resource "github_branch" "branches" {
  repository = github_repository.repo[each.key]
   for_each = toset([ "AUG23", "SEP23", "OCT23"])
    branch     = each.key
    source_branch = "master"

  depends_on = [
    github_repository.repo
  ]
}

resource "github_branch_protection" "nalinture" {
  repository_id  = github_repository.repo[each.key]
  for_each = toset( ["master", "AUG23"] )
  pattern  = each.key
  //allows_deletions = false

}

resource "github_repository_file" "files" {
repository          = github_repository.repo[each.key]
branch              = "master"
file                = ".gitignore"
content             = "**/*.tfstate"
commit_message      = "Managed by github.com/nalinture/terraform_learning"
commit_author       = "Terraform User"
commit_email        = "nalinkumarmurugesan@gmail.com"
overwrite_on_create = true

  depends_on = [
    github_repository.repo
  ]


}
