#!/bin/bash 

export GCP_PROJECT="du-hast-mich"
export REGION="us-central1"
export SUBNET_NAME="default" 
export METASTORE_NAME="dingometa"
export GCS_SCRIPT_PATH="gs://dingoproc/sql-scripts/audience.sql"
export BATCH_ID="create-target-audience-$(date +%s)"

# --- [Construct the full resource URIs] ---
export SUBNET_URI="projects/${GCP_PROJECT}/regions/${REGION}/subnetworks/${SUBNET_NAME}"
export METASTORE_URI="projects/${GCP_PROJECT}/locations/${REGION}/services/${METASTORE_NAME}"

gcloud dataproc batches submit spark-sql ${GCS_SCRIPT_PATH} \
    --project=${GCP_PROJECT} \
    --region=${REGION} \
    --batch=${BATCH_ID} \
    --subnet=${SUBNET_URI} \
    --metastore-service=${METASTORE_URI} \
    --properties="spark.sql.adaptive.enabled=true,spark.sql.adaptive.coalescePartitions.enabled=true,spark.sql.adaptive.advisoryPartitionSizeInBytes=104857600"

