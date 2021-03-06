[
  {
    "name": "${app_name}",
    "image": "${docker_image_url}",
    "essential": true,
    "cpu": 10,
    "memory": 500,
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "${container_path}",
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
