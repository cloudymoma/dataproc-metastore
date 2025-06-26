meta:
	gcloud services enable metastore.googleapis.com --project=du-hast-mich
	./create_meta.sh

update:
	gcloud storage cp audience.sql gs://dingoproc/sql-scripts/

run:
	./run.sh

.PHONY: update run meta
