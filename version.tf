terraform {
  required_version = ">= 1.3.6"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">= 1.81.73"
    }
  }
}
