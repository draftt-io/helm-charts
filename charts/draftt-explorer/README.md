# draftt-explorer

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for Draftt k8s explorer

## Installing the Chart

To install the draftt-explorer chart:

```bash
helm install draftt-explorer draftt-io/draftt-explorer \
  --set appConfig.clusterIdentifier="<YOUR_K8S_CLUSTER_IDENTIFIER>" \
  --namespace monitoring
```

To uninstall the chart:

```bash
helm uninstall draftt-explorer --namespace monitoring
```

## Upgrade from Draftt collector agent version 0.0.1

Use these instructions to upgrade an existing Draftt collector installation
from agent version `0.0.1`. They assume you followed the installation
instructions above.

Update the local Helm repository index:

```bash
helm repo update
```

### Review the current release values

```bash
helm get values draftt-explorer \
  --namespace monitoring \
  --output yaml
```

Review the values currently set for the release. Identify any values supported
by the current chart that should remain configured after the upgrade. The
upgrade uses `--reset-values`, so Helm will not retain these values
automatically.

### Standard upgrade

Upgrade using the agent v2 defaults and reapply the required cluster
identifier:

```bash
helm upgrade draftt-explorer draftt-io/draftt-explorer \
  --namespace monitoring \
  --reset-values \
  --set-string appConfig.clusterIdentifier="<YOUR_K8S_CLUSTER_IDENTIFIER>"
```

`--reset-values` removes the stored legacy values and applies the agent v2
chart defaults. Resources remain in `monitoring` because it is the Helm release
namespace.

### Customized installations

If you supplied overrides with `--set` or `--set-string`, add the relevant
overrides to the standard upgrade command.

If you supplied overrides with a values file, review and edit that file before
passing it to the upgrade command:

```bash
helm upgrade draftt-explorer draftt-io/draftt-explorer \
  --namespace <RELEASE_NAMESPACE> \
  --reset-values \
  --values <VALUES_FILE>
```

### Verify the upgrade

```bash
helm status draftt-explorer --namespace monitoring
kubectl get cronjob draftt-explorer --namespace monitoring
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.api.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-api-token"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt explorer and the secret name and key are as specified in the values.yaml file. |
| appConfig.api.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.api.drafttApiToken.secretName | string | `"draftt-api-token"` | The name of the secret |
| appConfig.api.drafttApiUrl | string | `"https://api.draftt.io/component/k8s"` | The draftt API URL |
| appConfig.clusterIdentifier | string | `""` | The cluster identifier, you can get it from the cluster overview page in the draftt console. <br> **Note**: for the integration to work correctly, the exact cluster identifier must be provided. |
| appConfig.logLevel | string | "info" | The log level to use for the draftt explorer Available options: "debug" \| "info" \| "warn" \| "error" |
| commonLabels | object | `{}` | Common labels to be added to all resources |
| cronjob.affinity | object | `{}` | Affinity for the cronjob |
| cronjob.annotations | object | `{}` | Annotations to be added to the cronjob |
| cronjob.backoffLimit | int | `1` | Number of retries before Kubernetes marks the Job as failed |
| cronjob.failedJobsHistoryLimit | int | `3` | The number of failed jobs to keep in the history. Older failed jobs beyond this limit are automatically deleted. |
| cronjob.labels | object | `{}` | Labels to be added to the cronjob |
| cronjob.nodeSelector | object | `{}` | Node selector for the cronjob |
| cronjob.restartPolicy | string | `"Never"` | The restart policy for the cronjob pod |
| cronjob.schedule | string | `"45 * * * *"` | CronJob timing configuration. The Draftt API decides whether a scan is due. |
| cronjob.successfulJobsHistoryLimit | int | `1` | The number of successful jobs to keep in the history. Older successful jobs beyond this limit are automatically deleted. |
| cronjob.tolerations | list | `[]` | Tolerations for the cronjob |
| cronjob.ttlSecondsAfterFinished | int | 3600 | The TTL for the cronjob pod after it is finished. <br> **Note**: The default value is 3600 seconds (1 hour). |
| image.pullPolicy | string | `"Always"` | Image pull policy to use for the Draftt explorer |
| image.pullSecrets | list | `[]` | Pull secrets to pull images from a private registry |
| image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the Draftt explorer |
| image.tag | string | `"2.0.0"` | Tag to use for the Draftt explorer |
| nameOverride | string | `""` | Override the chart name |
| rbac.annotations | object | `{}` | Annotations to be added to rbac resources |
| rbac.create | bool | `true` | Whether to create rbac resources <br> When set to false, a cluster role and cluster role binding must be created manually. |
| rbac.labels | object | `{}` | Labels to be added to rbac resources |
| resources.requests | object | `{"cpu":"500m","memory":"512Mi"}` | Resource requests for the draftt explorer |
| serviceAccount.annotations | object | `{}` | Annotations to be added to service account |
| serviceAccount.create | bool | `true` | Whether to create a service account. <br> **Note**: if you are using an existing service account, set this to false and provide the service account name in the name field. |
| serviceAccount.labels | object | `{}` | Labels to be added to service account |
| serviceAccount.name | string | `""` | The name of the service account. <br> If not set, and `serviceAccount.create` is true, a service account is created automatically using the fullname template. |
