/*data "terraform_remote_state" "remote_state_prod" {
    backend = "s3"
    config = {
        bucket  = "deerpark-terraform-state-prod"
        key     = "network/terraform.tfstate"
    }
}*/

module "example" {
  source   = "MitocGroup/terraform-remote-state/aws"
  version  = "0.0.8"
  config   = {
    bucket   = "deerpark-terraform-state-prod"
    key      = "network/terraform.tfstate"
  }
}

# data.terraform_remote_state.remote_state_prod.outputs.ecs_cluster_id

data "template_file" "task_definition_template" {
  template = file("${path.module}/task_definition.json.tpl")
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  container_definitions = data.template_file.task_definition_template.rendered
}

resource "aws_ecs_service" "worker" {
  name            = "worker"
  cluster         = data.terraform_remote_state.remote_state_prod.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
}
