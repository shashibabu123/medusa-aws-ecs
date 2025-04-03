resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["subnet-08d17c192bd820609", "subnet-034ad409bef42e2d8"]
    security_groups = ["sg-04db6af79ee53e8bc"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_target_group.arn
    container_name   = "medusa-container"
    container_port   = 9000
  }

  depends_on = [
    aws_lb_target_group.medusa_target_group,
    aws_lb_listener.medusa_listener
  ]
}

