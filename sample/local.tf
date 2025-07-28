resource "local_file" "exemplo" {
  filename = "example.txt"
  content  = var.content
}

variable "content" {
  type = string
}
