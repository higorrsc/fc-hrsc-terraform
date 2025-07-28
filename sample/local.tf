resource "local_file" "exemplo" {
  filename = "example.txt"
  content  = var.content
}

data "local_file" "example-content" {
  filename = "example.txt"
}

output "data-source-result" {
  value = data.local_file.example-content.content
  # Uncomment the line below to get the content in base64 format
  # value = data.local_file.example-content.content_base64
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
