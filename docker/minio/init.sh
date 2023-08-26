until (/usr/bin/mc config host add minio-prefect http://nginx-minio-prefect:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}) do echo '...waiting...' && sleep 1; done
/usr/bin/mc mb minio-prefect/${MINIO_PREFECT_FLOWS_BUCKET_NAME}
/usr/bin/mc mb minio-prefect/${MINIO_PREFECT_ARTIFACTS_BUCKET_NAME}
exit 0