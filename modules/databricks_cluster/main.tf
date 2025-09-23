# =============================================================================
# Databricks Cluster Configuration
# =============================================================================

resource "databricks_cluster" "this" {
  # Basic cluster configuration
  cluster_name            = var.cluster_name
  spark_version          = var.spark_version
  node_type_id          = var.node_type_id
  driver_node_type_id   = var.driver_node_type_id
  autotermination_minutes = var.autotermination_minutes
  is_pinned             = var.is_pinned
  enable_elastic_disk   = var.enable_elastic_disk
  policy_id             = var.policy_id
  data_security_mode    = var.data_security_mode

  # Cluster size configuration
  num_workers = var.cluster_mode == "fixed" ? var.num_workers : null

  dynamic "autoscale" {
    for_each = var.cluster_mode == "autoscale" ? [1] : []
    content {
      min_workers = var.autoscale_min_workers
      max_workers = var.autoscale_max_workers
    }
  }

  # Spark configuration
  spark_conf = merge({
    "spark.databricks.cluster.profile" : var.cluster_profile
    "spark.databricks.repl.allowedLanguages" : join(",", var.repl_allowed_languages)
  }, var.spark_conf)

  # Spark environment variables
  spark_env_vars = var.spark_env_vars

  # Custom tags
  custom_tags = merge({
    "Environment" = var.environment
    "ManagedBy"   = "Terraform"
  }, var.custom_tags)

  # Azure specific settings
  azure_attributes {
    availability       = var.azure_attributes.availability
    first_on_demand   = var.azure_attributes.first_on_demand
    spot_bid_max_price = var.azure_attributes.spot_bid_max_price
  }

  # Cluster log configuration
  cluster_log_conf {
    dbfs {
      destination = var.cluster_log_path
    }
  }

  # Initialize actions
  dynamic "init_scripts" {
    for_each = var.init_scripts
    content {
      dynamic "dbfs" {
        for_each = try([init_scripts.value.dbfs], [])
        content {
          destination = dbfs.value
        }
      }
      dynamic "file" {
        for_each = try([init_scripts.value.file], [])
        content {
          destination = file.value
        }
      }
      dynamic "s3" {
        for_each = try([init_scripts.value.s3], [])
        content {
          destination = s3.value.destination
          region      = s3.value.region
        }
      }
      dynamic "volumes" {
        for_each = try([init_scripts.value.volumes], [])
        content {
          destination = volumes.value
        }
      }
    }
  }

  # Library configuration
  dynamic "library" {
    for_each = var.libraries
    content {
      jar     = try(library.value.jar, null)
      egg     = try(library.value.egg, null)
      whl     = try(library.value.whl, null)
      pypi {
        package = try(library.value.pypi.package, null)
        repo    = try(library.value.pypi.repo, null)
      }
      maven {
        coordinates = try(library.value.maven.coordinates, null)
        repo        = try(library.value.maven.repo, null)
        exclusions  = try(library.value.maven.exclusions, [])
      }
      cran {
        package = try(library.value.cran.package, null)
        repo    = try(library.value.cran.repo, null)
      }
    }
  }

  # Permissions
  dynamic "permission" {
    for_each = var.permissions
    content {
      level       = permission.value.level
      user_name   = try(permission.value.user_name, null)
      group_name  = try(permission.value.group_name, null)
    }
  }

  # Workload configuration
  workload_type {
    clients = var.workload_type.clients
    config  = var.workload_type.config
  }

  # Docker configuration (if applicable)
  docker_image {
    url = var.docker_image.url
    basic_auth {
      username = var.docker_image.username
      password = var.docker_image.password
    }
  }

  # Enable photon acceleration if specified
  photon                        = var.enable_photon
  enable_local_disk_encryption = var.enable_local_disk_encryption
  single_user_name             = var.single_user_name
  idempotency_token           = var.idempotency_token

  # Add timeouts for cluster operations
  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    # Prevent accidental cluster deletion
    prevent_destroy = var.prevent_destroy

    # Ignore changes to these parameters during updates
    ignore_changes = var.ignore_changes
  }
}