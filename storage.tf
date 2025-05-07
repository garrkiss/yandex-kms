resource "yandex_storage_bucket" "student_bucket" {
  bucket     = "evgenii-bakulev-${formatdate("YYYYMMDD", timestamp())}"
  acl        = "public-read"
  force_destroy = true


  # Настройка серверного шифрования с использованием ключа KMS
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  depends_on = [yandex_kms_symmetric_key.bucket_key]
}


resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.student_bucket.bucket
  key    = "image.jpg"
  source = "image/image.jpg"
  acl    = "public-read"
}
