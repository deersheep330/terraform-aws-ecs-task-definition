variable "cloudwatch_group" {
  type = string
  default = "deerpark-ecs-cloudwatch"
}

variable "name_prefix" {
  description = "Name prefix of each resources"
  type = string
  default = "deerpark"
}

variable "LINE_TOKEN" {
  type = string
  default = "line_token"
}

variable "YU_LINE_TOKEN" {
  type = string
  default = "yu_line_token"
}
