variable "config" {
  type = object({
    aws_region = string
    ami = string
    instance_type = string
    environment = string
  })
}

variable "subnet_ids" {
  type = list(string)
}