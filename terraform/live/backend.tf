provider "aws" {
    region = var.region
    access_key = data.vault_aws_credentials.creds.access_key
    secret_key = data.vault_aws_credentials.creds.secret_key
    token = data.vault_aws_credentials.creds.security_token
    version = "~> 2.0"
}

terraform {
    required_version = "~> 0.12.0"
    backend "remote" {
        hostname = var.hostname
        organization = var.organization
        workspaces {
            name = var.workspace
        }
    }
}

data "terraform_remote_state" "log_tf" {
    backend = "remote"
    config = {
        hostname = var.hostname
        organization = var.organization
        workspaces = {
            name = var.log_tf
        }
    }
}

provider "vault" {
    address = var.vault_address
}

data "vault_aws_access_credentials" "creds" {
    backend = "aws"
    role = var.vault_role
    type = "sts"
}
