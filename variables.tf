variable "cloudwatch_group" {
  type = string
  default = "deerpark-ecs-cloudwatch"
}

variable "name_prefix" {
  description = "Name prefix of each resources"
  type = string
  default = "deerpark"
}
