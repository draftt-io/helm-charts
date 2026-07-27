# draftt-explorer

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for Draftt k8s explorer

## Installing the Chart

To install the draftt-explorer chart:

    helm install draftt-explorer draftt-io/draftt-explorer

To uninstall the chart:

    helm uninstall draftt-explorer

## Upgrading from agent 0.0.1

These instructions assume the existing release was installed without a values file:

```bash
helm install draftt-explorer draftt-io/draftt-explorer \
  --set appConfig.clusterIdentifier="<YOUR_K8S_CLUSTER_IDENTIFIER>" \
  --set appConfig.namespace="monitoring" \
  --namespace monitoring
```

Update the local repository index and confirm the existing release:

```bash
helm repo update
helm status draftt-explorer --namespace monitoring
```

Upgrade using the 2.0.0 defaults and reapply only the required cluster
identifier:

```bash
helm upgrade draftt-explorer draftt-io/draftt-explorer \
  --namespace monitoring \
  --version 2.0.0 \
  --reset-values \
  --set-string appConfig.clusterIdentifier="<YOUR_K8S_CLUSTER_IDENTIFIER>"
```

`--reset-values` removes the stored legacy `appConfig.namespace` value and
adopts the new 2.0.0 defaults. Resources remain in `monitoring` because it is
the Helm release namespace.

Verify the upgrade:

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
