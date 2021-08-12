## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.52.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.app_log_group_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.app_log_stream_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_access_point.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.efs_tgt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_iam_instance_profile.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_node_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_service_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.amazon_ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_ec2_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_configuration.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sqs_queue.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.sqs_fifo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_ami.amazon_linux_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.assume_task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_assume_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_node_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_service_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [template_file.app](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | Security Group ID associated with ALB | `string` | `""` | no |
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | ALB Target Group ARN | `string` | `""` | no |
| <a name="input_app_count"></a> [app\_count](#input\_app\_count) | Number of Docker containers to run | `string` | `"1"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application Name | `string` | n/a | yes |
| <a name="input_autoscale_desired"></a> [autoscale\_desired](#input\_autoscale\_desired) | Desired autoscale (number of EC2) | `string` | `"1"` | no |
| <a name="input_autoscale_max"></a> [autoscale\_max](#input\_autoscale\_max) | Maximum autoscale (number of EC2) | `string` | `"5"` | no |
| <a name="input_autoscale_min"></a> [autoscale\_min](#input\_autoscale\_min) | Minimum autoscale (number of EC2) | `string` | `"1"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | AWS Certificate Manager ARN for validated domain | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port number for the ECS Container to run on | `number` | `443` | no |
| <a name="input_container_shared_dir_path"></a> [container\_shared\_dir\_path](#input\_container\_shared\_dir\_path) | EFS shared mount path in container | `string` | `"/opt/shared"` | no |
| <a name="input_create_sqs"></a> [create\_sqs](#input\_create\_sqs) | Whether SQS queues need to be created | `string` | n/a | yes |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | Instance Type for ECS Cluster nodes | `string` | `"t2.micro"` | no |
| <a name="input_ecr_url"></a> [ecr\_url](#input\_ecr\_url) | ECR Repository URL | `string` | `""` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS cluster | `string` | `"ecs-cluster"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment where the state backend will live. | `string` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Health check path for the default target group | `string` | `"/"` | no |
| <a name="input_is_internal"></a> [is\_internal](#input\_is\_internal) | Creates external or internal load balancer | `string` | `"no"` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Specify launch type for ECS Cluster | `string` | `"FARGATE"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | CloudWatch Log Retention (in days) | `string` | `"90"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of Private Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of Public Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_queue_suffix"></a> [queue\_suffix](#input\_queue\_suffix) | Suffix to be added to queue names. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to launch ECS cluster in | `string` | `"us-east-1"` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | EBS Volume Size (in GB) | `string` | `"50"` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of EBS volume attached to ECS Cluster nodes | `string` | `"gp2"` | no |
| <a name="input_sqs_queue_type"></a> [sqs\_queue\_type](#input\_sqs\_queue\_type) | SQS Queue type to be created (fifo/standard) | `string` | `"standard"` | no |
| <a name="input_tag_application"></a> [tag\_application](#input\_tag\_application) | The short name of the application. | `string` | n/a | yes |
| <a name="input_tag_cost_center"></a> [tag\_cost\_center](#input\_tag\_cost\_center) | The cost center in which the costs will be billed. | `string` | n/a | yes |
| <a name="input_tag_key_contact"></a> [tag\_key\_contact](#input\_tag\_key\_contact) | The full name of the technical lead responsible for the project. | `string` | n/a | yes |
| <a name="input_tag_parent_project"></a> [tag\_parent\_project](#input\_tag\_parent\_project) | Product tower, funding source or key area that owns this application. | `string` | n/a | yes |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | The visibility timeout for the queue | `number` | `43200` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_ami_id"></a> [ecs\_ami\_id](#output\_ecs\_ami\_id) | ECS Optimized AMI ID |
| <a name="output_ecs_security_group_id"></a> [ecs\_security\_group\_id](#output\_ecs\_security\_group\_id) | Security Group ID attached to ECS nodes |
