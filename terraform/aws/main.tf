terraform {
    backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "ORC"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
        name = "data-analysis"
    }
    }
}

# An example resource that does nothing.
resource "null_resource" "example" {
    triggers = {
    value = "main tf!"
    }
}