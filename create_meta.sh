#!/bin/bash

export GCP_PROJECT="du-hast-mich"
export REGION="us-central1"
export METASTORE_NAME="dingometa"
export WAREHOUSE_DIR="gs://dingoproc/hive-warehouse"
export NETWORK_NAME="default"
export GCS_BUCKET="gs://dingoproc"

export METASTORE_SA="service-490779752600@gcp-sa-metastore.iam.gserviceaccount.com"
gsutil iam ch serviceAccount:${METASTORE_SA}:roles/storage.objectAdmin ${GCS_BUCKET}

echo "Submitting request to create metastore '${METASTORE_NAME}'. This will take 20-30 minutes..."
gcloud metastore services create ${METASTORE_NAME} \
    --project=${GCP_PROJECT} \
    --location=${REGION} \
    --tier=DEVELOPER \
    --endpoint-protocol=GRPC \
    --hive-metastore-version=3.1.2 \
    --network=${NETWORK_NAME} \
    --hive-metastore-configs="hive.metastore.warehouse.dir=${WAREHOUSE_DIR}"

gcloud metastore services describe ${METASTORE_NAME} \
    --project=${GCP_PROJECT} \
    --location=${REGION}

# export METASTORE_SA=$(gcloud metastore services describe ${METASTORE_NAME} --project=${GCP_PROJECT} --location=${REGION} --format="value(gcpServiceAccount)")

#echo "Granting permissions to ${METASTORE_SA} on bucket ${GCS_BUCKET}..."
#gsutil iam ch serviceAccount:${METASTORE_SA}:roles/storage.objectAdmin ${GCS_BUCKET}
