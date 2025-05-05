locals {
  user_data = <<EOF
#!/bin/bash
echo '<html><body><h1>MY SITE!!!!!</h1><img src="https://storage.yandexcloud.net/${yandex_storage_bucket.student_bucket.bucket}/${yandex_storage_object.image.key}" alt="Image"></body></html>' > /var/www/html/index.html
EOF
}

# Создание трех виртуальных машин с LAMP
resource "yandex_compute_instance" "lamp_vm" {
  count = 3
  name  = "lamp-vm-${count.index}"
  zone  = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd827b91d99psvq5fjit" # Образ LAMP
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
  }

  metadata = {
    user-data = local.user_data
  }

  depends_on = [yandex_storage_object.image]
}