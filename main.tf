terraform {
    backend "remote" {
        organization = "NikhilMSD0209"
    }
}

provider "github" {
    token = var.github_token
    owner = "Nikhil-595"
}

variable "github_token" {
    default = "2243"
}

resource "github_repository" "repo" {
    name = "my_first_repository_using_terraform"
    description = "created this repository using terraform"
}

resource "github_branch" "sub_branch1" {
    repository = "my_first_repository_using_terraform"
    branch = "abrakadabra"
    source_branch = "master"
    depends_on =[github_repository.repo]
}
