# draftt-explorer

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for Draftt k8s explorer

## Installing the Chart

To install the draftt-explorer chart:

    helm install draftt-explorer draftt-io/draftt-explorer

To uninstall the chart:

    helm uninstall draftt-explorer

## Run modes

The draftt-explorer chart supports two run modes:

- API mode
- Local mode

**Note**: Only one run mode can be enabled at a time. If both are enabled, API mode will override local mode.

### API mode

API mode is the default run mode. It is used to send the data to the Draftt API.

### Local mode

Local mode is used to output the data to the console.
It can be configured to output the data to one or both of the following:
- **configmap** - `draftt-k8s-report` ConfigMap in the namespace the draftt explorer is deployed in. To retrieve the data, run:
```bash
kubectl get configmap draftt-k8s-report -n <namespace> -o jsonpath='{.data.report\.json}'
```
- **stdout** - job's pod logs. To retrieve the data, run:
```bash
kubectl logs <job-name> -n <namespace>
```
**Note**: When using `stdout` output type, pod logs may become unavailable after job                                                            
  completion due to pod eviction, node termination, or resource cleanup. For reliable                                                             
  data persistence, use `configmap` or `both` output type.

## Kubernetes catalog cronjob

In API mode, `legacyCronJob` and `catalogCronJob` run side by side with independent workload settings. They share `appConfig`, common labels, service account, and RBAC. `appConfig.api.baseUrl` is used directly by the catalog job; the legacy job appends `/component/k8s`. Set either job's `enabled` value to `false` to omit it.

For upgrades from chart versions older than `2.0.0`, use:

```bash
helm upgrade draftt-explorer draftt-io/draftt-explorer \
  --version 2.0.0 \
  --reset-then-reuse-values \
  --wait \
  --cleanup-on-fail
```

If the existing release overrides `appConfig.api.drafttApiUrl`, migrate it to the API root in `appConfig.api.baseUrl` first.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.api.baseUrl | string | `"https://api.draftt.io"` | Shared Draftt API base URL. The legacy collector appends `/component/k8s`; the catalog collector uses it directly. |
| appConfig.api.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-api-token"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt explorer and the secret name and key are as specified in the values.yaml file. |
| appConfig.api.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.api.drafttApiToken.secretName | string | `"draftt-api-token"` | The name of the secret |
| appConfig.api.enabled | bool | true | Whether to enable API mode <br> **Note**: If `localMode.enabled` is enabled, set this to false. Otherwise, API mode will override local mode. |
| appConfig.clusterIdentifier | string | `""` | The cluster identifier, you can get it from the cluster overview page in the draftt console. <br> **Note**: for the integration to work correctly, the exact cluster identifier must be provided. |
| appConfig.localMode.enabled | bool | false | Whether to enable local mode |
| appConfig.localMode.outputType | string | "stdout" | Available options: "stdout" \| "configmap" \| "both" configmap - output the data to the `draftt-k8s-report` ConfigMap in the namespace the draftt explorer is deployed in <br> To retrieve the data, run: <br> `kubectl get configmap draftt-k8s-report -n <namespace> -o jsonpath='{.data.report.json}'` stdout - output the data to job's pod logs <br> To retrieve the data, run: <br> `kubectl logs <job-name> -n <namespace>` both - output the data to both stdout and configmap <br> **Note**: Apply only if `localMode.enabled` is true. |
| appConfig.logLevel | string | "info" | The log level to use for the draftt explorer Available options: "debug" \| "info" \| "warn" \| "error" |
| appConfig.namespace | string | `.Release.Namespace` | The namespace that all resources will be deployed on |
| catalogCronJob.affinity | object | `{}` | Affinity for the catalog cronjob |
| catalogCronJob.annotations | object | `{}` | Annotations to be added to the catalog cronjob and its pods |
| catalogCronJob.enabled | bool | `true` | Whether to deploy the Kubernetes catalog cronjob alongside the legacy cronjob |
| catalogCronJob.failedJobsHistoryLimit | int | `3` | The number of failed catalog jobs to keep in history |
| catalogCronJob.image.pullPolicy | string | `"Always"` | Image pull policy to use for the Kubernetes catalog collector |
| catalogCronJob.image.pullSecrets | list | `[]` | Pull secrets used by the Kubernetes catalog collector |
| catalogCronJob.image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the Kubernetes catalog collector |
| catalogCronJob.image.tag | string | `"2.0.0"` | Tag to use for the Kubernetes catalog collector |
| catalogCronJob.labels | object | `{}` | Labels to be added to the catalog cronjob and its pods |
| catalogCronJob.nodeSelector | object | `{}` | Node selector for the catalog cronjob |
| catalogCronJob.resources | object | `{"requests":{"cpu":"500m","memory":"512Mi"}}` | Resource requests and limits for the Kubernetes catalog collector |
| catalogCronJob.schedule | string | `"45 * * * *"` | Hourly catalog schedule, offset from the legacy cronjob. The Draftt API decides whether a scan is due. |
| catalogCronJob.successfulJobsHistoryLimit | int | `1` | The number of successful catalog jobs to keep in history |
| catalogCronJob.tolerations | list | `[]` | Tolerations for the catalog cronjob |
| catalogCronJob.ttlSecondsAfterFinished | int | 3600 | The TTL for a completed catalog job |
| commonLabels | object | `{}` | Common labels to be added to all resources |
| legacyCronJob.affinity | object | `{}` | Affinity for the cronjob |
| legacyCronJob.annotations | object | `{}` | Annotations to be added to the cronjob |
| legacyCronJob.enabled | bool | `true` | Whether to deploy the legacy Draftt explorer cronjob |
| legacyCronJob.failedJobsHistoryLimit | int | `3` | The number of failed jobs to keep in the history. Older failed jobs beyond this limit are automatically deleted. |
| legacyCronJob.image.pullPolicy | string | `"Always"` | Image pull policy to use for the legacy Draftt explorer |
| legacyCronJob.image.pullSecrets | list | `[]` | Pull secrets used by the legacy Draftt explorer |
| legacyCronJob.image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the legacy Draftt explorer |
| legacyCronJob.image.tag | string | `"0.0.1"` | Tag to use for the legacy Draftt explorer |
| legacyCronJob.labels | object | `{}` | Labels to be added to the cronjob |
| legacyCronJob.maxRetries | int | `3` | the maximum number of retries for the cronjob before it is marked as failed |
| legacyCronJob.nodeSelector | object | `{}` | Node selector for the cronjob |
| legacyCronJob.resources | object | `{"requests":{"cpu":"500m","memory":"512Mi"}}` | Resource requests and limits for the legacy Draftt explorer |
| legacyCronJob.restartPolicy | string | `"OnFailure"` | The restart policy for the cronjob pod |
| legacyCronJob.schedule | string | `"30 */7 * * *"` | Legacy cronjob timing config, you can build it at: https://crontab.guru <br> **Note**: Retaining the default value (every 7 hours at :30) is advised for best performance. Can be adjusted if needed. |
| legacyCronJob.successfulJobsHistoryLimit | int | `1` | The number of successful jobs to keep in the history. Older successful jobs beyond this limit are automatically deleted. |
| legacyCronJob.tolerations | list | `[]` | Tolerations for the cronjob |
| legacyCronJob.ttlSecondsAfterFinished | int | 3600 | The TTL for the cronjob pod after it is finished. <br> **Note**: The default value is 3600 seconds (1 hour). |
| nameOverride | string | `""` | Override the chart name |
| rbac.annotations | object | `{}` | Annotations to be added to rbac resources |
| rbac.create | bool | `true` | Whether to create rbac resources <br> **Note**: When set to true, the required rbac resources will be created according to the run mode. <br> When set to false, a cluster role and a cluster role binding should be created manually according to the run mode. |
| rbac.labels | object | `{}` | Labels to be added to rbac resources |
| serviceAccount.annotations | object | `{}` | Annotations to be added to service account |
| serviceAccount.create | bool | `true` | Whether to create a service account. <br> **Note**: if you are using an existing service account, set this to false and provide the service account name in the name field. |
| serviceAccount.labels | object | `{}` | Labels to be added to service account |
| serviceAccount.name | string | `""` | The name of the service account. <br> If not set, and `serviceAccount.create` is true, a service account is created automatically using the fullname template. |
