terraform {
  backend "azurerm" {
    storage_account_name = ""
    container_name       = "statefiles"
    key                  = "ringier/state."
    use_azuread_auth     = true
    subscription_id      = "subscriptionId"
    resource_group_name  = "resourcegroup"
  }
}
