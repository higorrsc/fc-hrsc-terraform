resource "local_file" "exemplo" {
  filename = "example.txt"
  content  = var.content
}

variable "content" {
  type = string
}

output "file_id" {
  value = resource.local_file.exemplo.id
}

output "content" {
  value = var.content
}
