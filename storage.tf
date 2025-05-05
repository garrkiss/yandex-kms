resource "yandex_storage_bucket" "student_bucket" {
  bucket     = "evgenii-bakulev-${formatdate("YYYYMMDD", timestamp())}"
  acl        = "public-read"
  force_destroy = true
}

resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.student_bucket.bucket
  key    = "image.jpg"
  source = "image/image.jpg"
  acl    = "public-read"
}
