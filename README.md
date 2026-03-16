# postgres-rclone

PostgreSQL + Rclone helm chart — deploys PostgreSQL with continuous WAL archiving and full backup/restore via [rclone](https://rclone.org/) to any supported remote.

## References

- https://www.postgresql.org/
- https://rclone.org/

## Install / upgrade

### From OCI

```sh
helm upgrade --install -n dev --create-namespace postgres-rclone oci://ghcr.io/sfmunoz/postgres-rclone --version 0.0.1
```

### Local

```sh
helm upgrade --install -n <namespace> --create-namespace -f secrets://secrets.yaml <flags> <name> .
```

Optional flags:
- `--set postgres.empty=true` — empty database (skip restore, create fresh)
- `--set postgres.terminationGracePeriodSeconds=10` — time to wait before killing the pod (default: 60s)

## Test

```sh
helm test -n <namespace> --logs <release-name>
helm test -n <namespace> --logs --filter name=<release-name>-backup-test <release-name>
helm test -n <namespace> --logs --filter name=<release-name>-pgbench-test <release-name>
```

## Uninstall

```sh
helm uninstall -n <namespace> <release-name>
kubectl delete namespaces <namespace>
```

## Dry-run / render templates

```sh
helm install --dry-run --debug --disable-openapi-validation -f secrets://secrets.yaml -n <namespace> <name> .
helm template .
```
