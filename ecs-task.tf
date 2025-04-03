resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::050451375845:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "medusa-container"
      image     = "050451375845.dkr.ecr.us-east-1.amazonaws.com/medusa-repo/medusa:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [{ containerPort = 9000 }]
    }
  ])
}

