[
  {
    "essential": true,
    "memory": 256,
    "name": "rent-service",
    "cpu": 128,
    "image": "696324379330.dkr.ecr.us-east-2.amazonaws.com/repo-svc-rent:latest",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${awslogs_region}",
        "awslogs-stream-prefix": "${awslogs_prefix}"
      }
    }
  }
]