terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "deerpark"
    workspaces {
      name = "terraform-aws-ecs-task-definition"
    }
  }
}

provider "aws" {}

data "terraform_remote_state" "remote_state_prod" {
  backend = "remote"
  config = {
    organization = "deerpark"
    workspaces = {
      name = "terraform-aws-ecs-task-definition"
    }
  }
}

# data.terraform_remote_state.remote_state_prod.outputs.ecs_cluster_id

data "template_file" "task_definition_template" {
  template = file("${path.module}/task_definition.json.tpl")
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "tf-prod-task-definition"
  container_definitions = data.template_file.task_definition_template.rendered
}

resource "aws_ecs_service" "ecs_service" {
  name = "tf-prod-ecs-service"
  cluster = data.terraform_remote_state.remote_state_prod.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count = 1
}
