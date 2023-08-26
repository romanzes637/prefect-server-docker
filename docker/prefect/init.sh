#!/bin/bash  
echo "
from prefect.filesystems import RemoteFileSystem
      
minio_block = RemoteFileSystem(
    basepath=\"s3://${MINIO_PREFECT_FLOWS_BUCKET_NAME}\",
    settings={
            \"key\": \"$MINIO_ROOT_USER\",
            \"secret\": \"$MINIO_ROOT_PASSWORD\",
            \"client_kwargs\": {\"endpoint_url\": \"$MINIO_ENDPOINT_URL\"},
    },
)
minio_block.save(\"${PREFECT_BLOCK_NAME}\", overwrite=True)" > module.py &&
PREFECT_API_URL=${PREFECT_API_URL_AUTH} prefect block register -f module.py
exit 0