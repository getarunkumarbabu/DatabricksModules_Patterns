# =============================================================================
# Example Usage of Databricks Cluster Module
# =============================================================================

module "databricks_cluster" {
  source = "../../modules/databricks_cluster"

  # Basic cluster configuration
  cluster_name            = "example-cluster"
  spark_version          = "11.3.x-scala2.12"
  node_type_id          = "Standard_DS3_v2"
  driver_node_type_id   = "Standard_DS3_v2"
  
  # Cluster size configuration
  cluster_mode           = "autoscale"
  autoscale_min_workers = 2
  autoscale_max_workers = 8
  autotermination_minutes = 120

  # Advanced settings
  data_security_mode    = "SINGLE_USER"
  enable_elastic_disk   = true
  enable_photon        = true

  # Spark configuration
  spark_conf = {
    "spark.speculation"                    = true
    "spark.scheduler.mode"                = "FAIR"
    "spark.databricks.cluster.profile"    = "serverless"
    "spark.databricks.adaptive.enabled"    = true
    "spark.databricks.acl.dfAclsEnabled"  = true
  }

  # Environment variables
  spark_env_vars = {
    "PYSPARK_PYTHON" = "/databricks/python3/bin/python3"
  }

  # Azure configuration
  azure_attributes = {
    availability        = "ON_DEMAND"
    first_on_demand    = 1
    spot_bid_max_price = -1
  }

  # Cluster init scripts
  init_scripts = [
    {
      dbfs = "dbfs:/init-scripts/install-packages.sh"
    },
    {
      file = "/local/path/to/init.sh"
    }
  ]

  # Libraries to install
  libraries = [
    {
      pypi = {
        package = "scikit-learn==1.0.2"
      }
    },
    {
      maven = {
        coordinates = "com.databricks:spark-xml_2.12:0.14.0"
      }
    },
    {
      jar = "dbfs:/libraries/custom.jar"
    }
  ]

  # Permissions
  permissions = [
    {
      level      = "CAN_MANAGE"
      group_name = "data-scientists"
    },
    {
      level      = "CAN_ATTACH_TO"
      group_name = "analysts"
    }
  ]

  # Custom tags
  custom_tags = {
    "Environment" = "production"
    "Department"  = "data-science"
    "Project"     = "ml-pipeline"
  }

  # Timeouts
  timeouts = {
    create = "60m"
    update = "60m"
    delete = "30m"
  }

  # Lifecycle settings
  prevent_destroy = false
  ignore_changes = [
    "spark_conf.spark.databricks.cluster.profile",
    "library"
  ]
}