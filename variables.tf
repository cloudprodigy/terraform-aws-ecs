variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string

}

variable "create_sqs" {
  description = "Whether SQS queues need to be created"
  type        = string

}

variable "queue_suffix" {
  description = "Suffix to be added to queue names."
  type        = list(string)
}

variable "sqs_queue_type" {
  description = "SQS Queue type to be created (fifo/standard)"
  type        = string
  default     = "standard"
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  type        = number
  default     = 43200
}

#ALB

variable "certificate_arn" {
  description = "AWS Certificate Manager ARN for validated domain"
  type        = string

}
variable "is_internal" {
  type        = string
  description = "Creates external or internal load balancer"
  default     = "no"
}
variable "health_check_path" {
  description = "Health check path for the default target group"
  type        = string
  default     = "/"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  type        = list(string)
  description = "List of Public Subnet IDs"

}

variable "private_subnets" {
  type        = list(string)
  description = "List of Private Subnet IDs"

}


variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
  default     = "ecs-cluster"
}

variable "ec2_instance_type" {
  description = "Instance Type for ECS Cluster nodes"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_type" {
  description = "Type of EBS volume attached to ECS Cluster nodes"
  type        = string
  default     = "gp2"

}

variable "root_volume_size" {
  description = "EBS Volume Size (in GB)"
  type        = string
  default     = "50"
}

variable "app_count" {
  type        = string
  description = "Number of Docker containers to run"
  default     = "1"
}

variable "log_retention_in_days" {
  description = "CloudWatch Log Retention (in days)"
  type        = string
  default     = "90"

}

variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  type        = string
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  type        = string
  default     = "5"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  type        = string
  default     = "1"
}

variable "container_shared_dir_path" {
  description = "EFS shared mount path in container"
  type        = string
  default     = "/opt/shared"

}

variable "ecr_url" {
  description = "ECR Repository URL"
  type        = string
  default     = ""
}

variable "alb_security_group_id" {
  description = "Security Group ID associated with ALB"
  type        = string
  default     = ""
}

variable "launch_type" {
  description = "Specify launch type for ECS Cluster"
  default     = "FARGATE"
  type        = string
}

variable "region" {
  description = "AWS Region to launch ECS cluster in"
  type        = string
  default     = "us-east-1"
}

variable "container_port" {
  description = "Port number for the ECS Container to run on"
  type        = number
  default     = 443
}

variable "alb_target_group_arn" {
  description = "ALB Target Group ARN"
  type        = string
  default     = ""
}
variable "environment" {
  type        = string
  description = "The environment where the state backend will live."
}

variable "tag_parent_project" {
  description = "Product tower, funding source or key area that owns this application."
  type        = string

  validation {
    condition = ((length(var.tag_parent_project) > 0 && length(var.tag_parent_project) <= 2048) &&
    can(regex("\\w+([\\s-_]\\w+)*", var.tag_parent_project)))
    error_message = "Must contain at least one alphanumeric character. Whitespace characters, underscores and dash are allowed inside the string."
  }
}

variable "tag_application" {
  description = "The short name of the application."
  type        = string

  validation {
    condition = ((length(var.tag_application) > 0 && length(var.tag_application) <= 2048) &&
    can(regex("\\w+([\\s-_]\\w+)*", var.tag_application)))
    error_message = "Must contain at least one alphanumeric character. Whitespace characters, underscores and dash are allowed inside the string."
  }
}

variable "tag_cost_center" {
  description = "The cost center in which the costs will be billed."
  type        = string

  validation {
    condition = ((length(var.tag_cost_center) > 0 && length(var.tag_cost_center) <= 15) &&
    can(regex("^[0-9]*$", var.tag_cost_center)))
    error_message = "Must contain only numeric characters with max length of 15."
  }
}

variable "tag_key_contact" {
  description = "The full name of the technical lead responsible for the project."
  type        = string

  validation {
    condition = ((length(var.tag_key_contact) > 0 &&
      length(var.tag_key_contact) <= 2048) &&
    can(regex("[\\/\\w]+([\\s-_][\\/\\w]+)*", var.tag_key_contact)))
    error_message = "Must contain at least one alphanumeric character. Whitespace characters, underscores, dash and forward slashes are allowed inside the string."
  }
}


locals {
  common_tags = {
    Parent_Project = var.tag_parent_project
    Application    = var.tag_application
    Cost_Center_ID = var.tag_cost_center
    environment    = var.environment
    Key_Contact    = var.tag_key_contact
  }

}


