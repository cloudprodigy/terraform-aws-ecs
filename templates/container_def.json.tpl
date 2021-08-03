[
  {
    "name": "${app_name}",
    "image": "${docker_image_url}",
    "essential": true,
    "cpu": 10,
    "memory": 128,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0
      },
      {
        "containerPort": 443,
        "hostPort": 0
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/opt/shared",
        "sourceVolume": "shared"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${app_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${app_name}-log-stream"
      }
    }
  }
]
