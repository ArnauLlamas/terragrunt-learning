resource "random_pet" "this" {}
resource "random_id" "this" {
  byte_length = 8
}

output "random_id" {
  value = random_id.this.id
}

output "random_pet" {
  value = random_pet.this.id
}
