# draftt-explorer

![Version: 0.1.6](https://img.shields.io/badge/Version-0.1.6-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for Draftt k8s explorer.

## Installing the Chart

To install the draftt-explorer chart:

    helm install draftt-explorer draftt-io/draftt-explorer

To uninstall the chart:

    helm delete draftt-explorer
    
## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.api.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-api-token"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt explorer and the secret name and key are as specified in the values.yaml file. |
| appConfig.api.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.api.drafttApiToken.secretName | string | `"draftt-api-token"` | The name of the secret |
| appConfig.api.drafttApiUrl | string | `"https://api.draftt.io/component/k8s"` | The draftt API URL |
| appConfig.aws.accessKeyId | string | `""` |  |
| appConfig.aws.region | string | `""` |  |
| appConfig.aws.secretAccessKey | string | `""` |  |
| appConfig.clusterIdentifier | string | `""` | The cluster identifier, you can get it from the cluster overview page in the draftt console. <br> **Note**: for the integration to work correctly, the exact cluster identifier must be provided. |
| appConfig.namespace | string | `"monitoring"` | The namespace that resources will be deployed on |
| appConfig.s3 | object | `{"bucketName":"","endpoint":""}` | S3 configuration |
| clusterRole.annotations | object | `{}` | Annotations to be added to cluster role |
| clusterRole.labels | object | `{}` | Labels to be added to cluster role |
| clusterRoleBinding.labels | object | `{}` | Labels to be added to cluster role binding |
| cronjob.annotations | object | `{}` | Annotations to be added to the cronjob |
| cronjob.failedJobsHistoryLimit | int | `3` | The number of failed jobs to keep in the history. Older failed jobs beyond this limit are automatically deleted. |
| cronjob.image.pullPolicy | string | `"Always"` | Image pull policy to use for the Draftt explorer |
| cronjob.image.pullSecrets | list | `[]` | Pull secrets to pull images from a private registry |
| cronjob.image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the Draftt explorer |
| cronjob.image.tag | string | `"0.0.1"` | Tag to use for the Draftt explorer |
| cronjob.labels | object | `{}` | Labels to be added to the cronjob |
| cronjob.maxRetries | int | `3` | the maximum number of retries for the cronjob before it is marked as failed |
| cronjob.nodeSelector | object | `{}` | Node selector |
| cronjob.resources | object | `{"requests":{"cpu":"100m","memory":"256Mi"}}` | Resource limits and requests for the draftt explorer pods |
| cronjob.restartPolicy | string | `"OnFailure"` | The restart policy for the cronjob pod |
| cronjob.schedule | string | `"0 */8 * * *"` | cronjob timing config, you can build it at: https://crontab.guru |
| cronjob.successfulJobsHistoryLimit | int | `1` | The number of successful jobs to keep in the history. Older successful jobs beyond this limit are automatically deleted. |
| serviceAccount.annotations | object | `{}` | Annotations to be added to service account |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.labels | object | `{}` | Labels to be added to service account |
| serviceAccount.name | string | `"draftt-explorer"` | The name of the service account |
| serviceAccount.roleArn | string | `""` |  |

