# draftt-explorer

![Version: 0.1.8](https://img.shields.io/badge/Version-0.1.8-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.api.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-api-token"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt explorer and the secret name and key are as specified in the values.yaml file. |
| appConfig.api.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.api.drafttApiToken.secretName | string | `"draftt-api-token"` | The name of the secret |
| appConfig.api.drafttApiUrl | string | `"https://api.draftt.io/component/k8s"` | The draftt API URL |
| appConfig.api.enabled | bool | true | Whether to enable API mode <br> **Note**: If `localMode.enabled` is enabled, set this to false. Otherwise, API mode will override local mode. |
| appConfig.clusterIdentifier | string | `""` | The cluster identifier, you can get it from the cluster overview page in the draftt console. <br> **Note**: for the integration to work correctly, the exact cluster identifier must be provided. |
| appConfig.localMode.enabled | bool | false | Whether to enable local mode |
| appConfig.localMode.outputType | string | "stdout" | Available options: "stdout" | "configmap" | "both" configmap - output the data to the `draftt-k8s-report` ConfigMap in the namespace the draftt explorer is deployed in <br> To retrieve the data, run: <br> `kubectl get configmap draftt-k8s-report -n <namespace> -o jsonpath='{.data.report.json}'` stdout - output the data to job's pod logs <br> To retrieve the data, run: <br> `kubectl logs <job-name> -n <namespace>` both - output the data to both stdout and configmap <br> **Note**: Apply only if `localMode.enabled` is true. |
| appConfig.namespace | string | `.Release.Namespace` | The namespace that all resources will be deployed on |
| commonLabels | object | `{}` | Common labels to be added to all resources |
| cronjob.affinity | object | `{}` | Affinity for the cronjob |
| cronjob.annotations | object | `{}` | Annotations to be added to the cronjob |
| cronjob.failedJobsHistoryLimit | int | `3` | The number of failed jobs to keep in the history. Older failed jobs beyond this limit are automatically deleted. |
| cronjob.labels | object | `{}` | Labels to be added to the cronjob |
| cronjob.maxRetries | int | `3` | the maximum number of retries for the cronjob before it is marked as failed |
| cronjob.nodeSelector | object | `{}` | Node selector for the cronjob |
| cronjob.restartPolicy | string | `"OnFailure"` | The restart policy for the cronjob pod |
| cronjob.schedule | string | `"30 */7 * * *"` | cronjob timing config, you can build it at: https://crontab.guru <br> **Note**: Retaining the default value of every 7 and 30 minutes is advised for best performance.  Can be adjusted if needed. |
| cronjob.successfulJobsHistoryLimit | int | `1` | The number of successful jobs to keep in the history. Older successful jobs beyond this limit are automatically deleted. |
| cronjob.tolerations | list | `[]` | Tolerations for the cronjob |
| cronjob.ttlSecondsAfterFinished | int | 3600 | The TTL for the cronjob pod after it is finished. <br> **Note**: The default value is 3600 seconds (1 hour). |
| image.pullPolicy | string | `"Always"` | Image pull policy to use for the Draftt explorer |
| image.pullSecrets | list | `[]` | Pull secrets to pull images from a private registry |
| image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the Draftt explorer |
| image.tag | string | `"0.0.1"` | Tag to use for the Draftt explorer |
| nameOverride | string | `""` | Override the chart name |
| rbac.annotations | object | `{}` | Annotations to be added to rbac resources |
| rbac.create | bool | `true` | Whether to create rbac resources <br> **Note**: When set to true, the required rbac resources will be created according to the run mode. <br> When set to false, a cluster role and a cluster role binding should be created manually according to the run mode. |
| rbac.labels | object | `{}` | Labels to be added to rbac resources |
| resources.requests | object | `{"cpu":2,"memory":"2Gi"}` | Resource requests for the draftt explorer |
| serviceAccount.annotations | object | `{}` | Annotations to be added to service account |
| serviceAccount.create | bool | `true` | Whether to create a service account. <br> **Note**: if you are using an existing service account, set this to false and provide the service account name in the name field. |
| serviceAccount.labels | object | `{}` | Labels to be added to service account |
| serviceAccount.name | string | `""` | The name of the service account. <br> If not set, and `serviceAccount.create` is true, a service account is created automatically using the fullname template. |
| serviceAccount.roleArn | string | `""` | if `appConfig.s3Mode.enabled` is true, provide an AWS IAM Role ARN for the service account with S3 access. |