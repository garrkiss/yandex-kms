resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key"
  description       = "Ключ KMS для шифрования бакета Object Storage"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год
}
