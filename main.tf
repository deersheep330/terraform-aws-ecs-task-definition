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

data "template_file" "template" {
  template = file("${path.module}/task_definition.json.tpl")
  vars = {
    awslogs_group = var.cloudwatch_group
    awslogs_region = data.aws_region.region.name
    awslogs_prefix = var.name_prefix
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.name_prefix}-ecs-task-definition"
  container_definitions = data.template_file.template.rendered
}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.name_prefix}-ecs-service"
  cluster = data.terraform_remote_state.remote_state.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count = 1
}
