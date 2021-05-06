terraform {
  backend "s3" {
    bucket = "deerpark-terraform-state"
    key = "terraform-aws-ecs-task-definition/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {}

data "aws_region" "region" {}

data "terraform_remote_state" "remote_state" {
  backend = "s3"
  config = {
    bucket = "deerpark-terraform-state"
    key = "terraform-aws-ecs-free-tier/terraform.tfstate"
    region = "us-east-2"
  }
}
# data.terraform_remote_state.remote_state.outputs.ecs_cluster_id

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = var.cloudwatch_group
}

data "template_file" "container_definition" {
  template = file("${path.module}/container_definition.json.tpl")
  vars = {
    db_connection_url = data.terraform_remote_state.remote_state.outputs.rds_connection_url
    line_token = var.line_token
    yu_line_token = var.yu_line_token
    awslogs_group = var.cloudwatch_group
    awslogs_region = data.aws_region.region.name
    awslogs_prefix = var.name_prefix
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.name_prefix}-ecs-task-definition"
  container_definitions = data.template_file.container_definition.rendered
}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.name_prefix}-ecs-service"
  cluster = data.terraform_remote_state.remote_state.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count = 1
}
