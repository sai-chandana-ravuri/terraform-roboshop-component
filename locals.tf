locals {
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
     common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }
    ami_id = data.aws_ami.joindevops.id
    sg_id = data.aws_ssm_parameter.sg_id
    health_check_path = var.component == "frontend" ? "/" : "/health"
    port_number = var.component == "frontend" ? 80 : 8080
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    backend_alb_listener_arn_id = data.aws_ssm_parameter.backend_alb_listener_arn.value
    frontend_alb_listener_arn_id = data.aws_ssm_parameter.frontend_alb_listener_arn.value
    alb_listener_arn_id = var.component == "frontend" ? local.frontend_alb_listener_arn_id : local.backend_alb_listener_arn_id
    host_header = var.component == "frontend" ? "${var.component}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
}