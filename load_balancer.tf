# Создание целевой группы для балансировщика
resource "yandex_lb_target_group" "lamp_target_group" {
  name = "lamp-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.lamp_vm
    content {
      subnet_id = yandex_vpc_subnet.public_subnet.id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

# Создание сетевого балансировщика
resource "yandex_lb_network_load_balancer" "lamp_lb" {
  name = "lamp-load-balancer"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp_target_group.id
    healthcheck {
      name = "http"
      interval = 10
      timeout  = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}