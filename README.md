# Dockerized self-hosted Prefect server

See Prefect [docs](https://docs.prefect.io/latest/host/) for more information

See also:
* https://github.com/flavienbwk/prefect-docker-compose
* https://github.com/rpeden/prefect-docker-compose

## How to deploy
1. Go to docker directory
```sh
cd docker
```
2. Generate password for username of nginx proxy (e.g. for username "user")
```sh
htpasswd -c .htpasswd user
```
3. Copy and modify "dotenv" files from examples
```sh
cp .env.example .env
cp .env.secret.example .env.secret
```
> Set HTPASSWD_USERNAME:HTPASSWD_PASSWORD from .htpasswd to PREFECT_API_URL_AUTH and at .env.secret
4. Run server (Prefect)
```sh
docker compose --profile server up -d
``` 
Check Prefect UI at http://YOUR_HOST:4200

Check Prefect API at http://YOUR_HOST:4200/api/hello

Check MinIO Console at http://YOUR_HOST:9001

Check pgadmin at http://YOUR_HOST:5050

5. Deploy and run test flow

Build
```sh
prefect deployment build -sb remote-file-system/minio -n test_deployment -p default-process-pool test.py:greetings
```

Apply
```sh
prefect deployment apply greetings-deployment.yaml
```
Check deployment at Prefect UI http://YOUR_HOST:4200/deployments

Run
```sh
prefect deployment run test\ flow/test_deployment
```
Check runs at Prefect UI http://YOUR_HOST:4200/flow-runs

6. Run agents(s) or worker(s)
```sh
docker compose --profile agent up -d --scale agent=3
docker compose --profile worker up -d --scale worker=3
```
Check agents/workers at Prefect UI http://YOUR_HOST:4200/work-pools/work-pool/default-process-pool