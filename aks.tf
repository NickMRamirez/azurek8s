variable "subscription_id" {}    
variable "service_principal_client_id" {}
variable "service_principal_client_secret" {}
variable "tenant_id" {}

provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
    tenant_id = "${var.tenant_id}"
}

resource "azurerm_resource_group" "k8stest_resourcegroup" {
    name = "k8stest_resourcegroup"
    location = "East US"
}

resource "azurerm_container_service" "k8stest_containersvc" {
    name = "k8stest_containersvc"
    location = "${azurerm_resource_group.k8stest_resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.k8stest_resourcegroup.name}"
    orchestration_platform = "Kubernetes"

    master_profile {
        count = 1
        dns_prefix = "k8stestmaster1"
    }

    linux_profile {
        admin_username = "k8suser"

        ssh_key {
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXK85hZafDwF694mJCEorluTowFHIbNbaNFroBoNrYqfx8GbGrIvWvZUI1fORTv03lyIgMe1u5NQcCJBS0LoachKqfLbKchP8qiQgn//WX9rY6tHK7g3q0YF/0qAlqW1Iln3ZmFAP0P8ZUM2sBOXoxmg7JDnuhJcsYEBMqCgOI661DcdZ7Mm51dtWS6tm2O3F/fPBbw1yRq8TjCrDjAk7oluY/iF6Qd36y2/wVHQCVTyvvh+1jAYxVdF+kL6exiDjMNWzg3Va64m1eEXprvRAMTAdsJIC2/BnL7yaEooavZKM9USv4dO1ui4uZeNDHLfFy6MABWbeRjjIb1agqXO9/ nramirez@HMBX1CARBON0286"
        }
    }

    agent_pool_profile {
        name = "default"
        count = 1
        dns_prefix = "k8stestagent1"
        vm_size = "Standard_A0"
    }

    service_principal {
        client_id = "${var.service_principal_client_id}"
        client_secret = "${var.service_principal_client_secret}"
    }

    diagnostics_profile {
        enabled = false
    }

    tags {
        Environment = "Test"
    }
}
