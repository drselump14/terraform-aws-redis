variable "namespace" {
  type = string
}

variable "stage" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "cluster_size" {
  type = number
  default = 2
}

variable "instance_type" {
  type = string
  default = "cache.t2.micro"
}

variable "engine_version" {
  type = string
  default = "4.0.10"
}

variable "default_port" {
  type = number
  default = 6379
}

variable "availability_zones" {
  type = list(string)
}
