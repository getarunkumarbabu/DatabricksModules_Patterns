resource "databricks_job" "this" {
  name = var.name

  task {
    task_key = "notebook_task"
    notebook_task {
      notebook_path = var.notebook_path
    }

    new_cluster {
      spark_version = var.spark_version
      node_type_id  = var.node_type_id
      spark_conf    = var.spark_conf
    }
  }

    // max_retries is deprecated in newer provider versions and is intentionally
    // not set here. See module README for alternatives (use runs API to retry).
  }
