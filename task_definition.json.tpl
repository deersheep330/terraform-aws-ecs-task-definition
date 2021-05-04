[
  {
    "essential": true,
    "memory": 256,
    "name": "rent-service",
    "cpu": 128,
    "image": "696324379330.dkr.ecr.us-east-2.amazonaws.com/repo-svc-rent:latest",
    "environment": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.cloudwatch_group}",
        "awslogs-region": "us-east-2",
        "awslogs-stream-prefix": "tf-rent"
      }
    }
  }
]