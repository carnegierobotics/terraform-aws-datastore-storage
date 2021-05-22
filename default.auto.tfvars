# This file is included by default in terraform plans

enabled = true

availability_zones = ["us-east-1a", "us-east-1b"]

engine = "aurora-postgresql"

engine_mode = "serverless"

engine_version = "10.14"

cluster_family = "aurora-postgresql10"

cluster_size = 0

admin_user = "admin"

admin_password = "admin_password"

db_name = "test_db"
