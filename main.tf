module "bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "0.36.0"

  versioning_enabled = true

  # Disable current object expiration, and expire non-current objects after one week
  lifecycle_rules = [
    {
      prefix  = null
      enabled = true
      tags    = {}

      enable_glacier_transition        = false
      enable_deeparchive_transition    = false
      enable_standard_ia_transition    = false
      enable_current_object_expiration = false

      abort_incomplete_multipart_upload_days         = 1
      noncurrent_version_glacier_transition_days     = 0
      noncurrent_version_deeparchive_transition_days = 0
      noncurrent_version_expiration_days             = 7

      standard_transition_days    = 0
      glacier_transition_days     = 0
      deeparchive_transition_days = 0
      expiration_days             = 30 # Meaningless, as we disable current object expiration
    }
  ]

  context = module.this.context
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.17.0"

  cidr_block = "172.16.0.0/16"

  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "0.28.0"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context
}

module "rds_cluster" {
  source  = "cloudposse/rds-cluster/aws"
  version = "0.45.0"
  
  engine               = var.engine
  engine_mode          = var.engine_mode
  cluster_family       = var.cluster_family
  cluster_size         = var.cluster_size
  admin_user           = var.admin_user
  admin_password       = var.admin_password
  db_name              = var.db_name
  vpc_id               = module.vpc.vpc_id
  subnets              = module.subnets.private_subnet_ids
  security_groups      = [module.vpc.vpc_default_security_group_id]
  enable_http_endpoint = true
  
  scaling_configuration = [
    {
      auto_pause               = true
      max_capacity             = 4
      min_capacity             = 2
      seconds_until_auto_pause = 300
      timeout_action           = "ForceApplyCapacityChange"
    }
  ]

  context = module.this.context
}