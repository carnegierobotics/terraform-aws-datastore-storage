variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "engine" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  type        = string
  description = "The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless`"
  default     = "serverless"
}

variable "engine_version" {
  type        = string
  description = "The database engine version."
  default     = "10.14"
}

variable "cluster_family" {
  type        = string
  description = "The family of the DB cluster parameter group"
  default     = "aurora-postgresql10"
}

variable "cluster_size" {
  type        = number
  description = "Number of DB instances to create in the cluster"
  default     = 0
}

variable "admin_user" {
  type        = string
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
  default     = "admin_user"
}

variable "admin_password" {
  type        = string
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user"
  default     = "admin_password"
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "default_db"
}
