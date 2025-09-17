# Databricks Library Module

This module manages library installations on a Databricks cluster using the `databricks_library` resource.

## Inputs

- `cluster_id` (string) - ID of the cluster to install the library on
- `maven_coordinates` (string, optional) - Maven coordinates (groupId:artifactId:version)
- `maven_repo` (string, optional) - Maven repository URL
- `pypi_package` (string, optional) - PyPI package specification
- `pypi_repo` (string, optional) - PyPI repository URL
- `whl_file` (string, optional) - Path to .whl file in DBFS
- `jar_file` (string, optional) - Path to .jar file in DBFS

## Outputs

- `library_status` - Status of the library installation

## Example

```hcl
# Install PyPI package
module "numpy_lib" {
  source = "../modules/databricks_library"
  
  cluster_id   = "existing-cluster-id"
  pypi_package = "numpy==1.21.0"
}

# Install Maven package
module "spark_lib" {
  source = "../modules/databricks_library"
  
  cluster_id         = "existing-cluster-id"
  maven_coordinates = "org.apache.spark:spark-avro_2.12:3.1.2"
}
```

## Notes

- Only one library type can be specified per module instance
- Libraries can be installed from:
  - PyPI packages
  - Maven artifacts
  - Wheel files (.whl)
  - JAR files
- For custom artifacts, upload them to DBFS first