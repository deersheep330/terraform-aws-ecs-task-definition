[
  {
    "essential": true,
    "memory": 256,
    "name": "rent-service",
    "cpu": 128,
    "image": "696324379330.dkr.ecr.us-east-2.amazonaws.com/repo-svc-rent:latest",
    "environment": [
      { "name": "DB_CONNECTION_URL", "value": "dummy_connection_url" },
      { "name": "LINE_TOKEN", "value": "dummy_line_token" },
      { "name": "YU_LINE_TOKEN", "value": "dummy_yu_line_token" }
    ],
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