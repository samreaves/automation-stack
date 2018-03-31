resource "aws_ecs_cluster" "automation-stack-ecs-cluster" {
    name = "${var.ecs_cluster}"
}
