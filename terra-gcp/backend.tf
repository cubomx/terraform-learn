terraform {
    backend "remote" {
      organization = "DoU-TFE"

      workspaces {
        name = "CaaS-sergio"
      }
    }
}