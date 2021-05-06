variable "cloudwatch_group" {
  type = string
  default = "deerpark-ecs-cloudwatch"
}

variable "name_prefix" {
  description = "Name prefix of each resources"
  type = string
  default = "deerpark"
}

variable "line_token" {
  type = string
  default = "line_token"
}

variable "yu_line_token" {
  type = string
  default = "yu_line_token"
}
