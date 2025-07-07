# draftt-explorer

![Version: 0.1.7](https://img.shields.io/badge/Version-0.1.7-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for Draftt k8s explorer

## Installing the Chart

To install the draftt-explorer chart:

    helm install draftt-explorer draftt-io/draftt-explorer

To uninstall the chart:

    helm uninstall draftt-explorer

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.api.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-api-token"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt explorer and the secret name and key are as specified in the values.yaml file. |
| appConfig.api.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.api.drafttApiToken.secretName | string | `"draftt-api-token"` | The name of the secret |
| appConfig.api.drafttApiUrl | string | `"https://api.draftt.io/component/k8s"` | The draftt API URL |
| appConfig.clusterIdentifier | string | `""` | The cluster identifier, you can get it from the cluster overview page in the draftt console. <br> **Note**: for the integration to work correctly, the exact cluster identifier must be provided. |
| appConfig.namespace | string | `.Release.Namespace` | The namespace that all resources will be deployed on |
| appConfig.s3Mode.accessKeyId | string | `""` | The AWS access key ID |
| appConfig.s3Mode.bucketName | string | `""` | The S3 bucket name |
| appConfig.s3Mode.enabled | bool | `false` | Whether to enable S3 mode |
| appConfig.s3Mode.endpoint | string | `""` | The S3 endpoint |
| appConfig.s3Mode.region | string | `""` | The AWS region |
| appConfig.s3Mode.secretAccessKey | string | `""` | The AWS secret access key |
| commonLabels | object | `{}` | Common labels to be added to all resources |
| cronjob.affinity | object | `{}` | Affinity for the cronjob |
| cronjob.annotations | object | `{}` | Annotations to be added to the cronjob |
| cronjob.failedJobsHistoryLimit | int | `3` | The number of failed jobs to keep in the history. Older failed jobs beyond this limit are automatically deleted. |
| cronjob.labels | object | `{}` | Labels to be added to the cronjob |
| cronjob.maxRetries | int | `3` | the maximum number of retries for the cronjob before it is marked as failed |
| cronjob.nodeSelector | object | `{}` | Node selector for the cronjob |
| cronjob.restartPolicy | string | `"OnFailure"` | The restart policy for the cronjob pod |
| cronjob.schedule | string | `"0 */8 * * *"` | cronjob timing config, you can build it at: https://crontab.guru <br> **Note**: Retaining the default value of every 8 hours is advised for best performance.  Can be adjusted if needed. |
| cronjob.successfulJobsHistoryLimit | int | `1` | The number of successful jobs to keep in the history. Older successful jobs beyond this limit are automatically deleted. |
| cronjob.tolerations | list | `[]` | Tolerations for the cronjob |
| image.pullPolicy | string | `"Always"` | Image pull policy to use for the Draftt explorer |
| image.pullSecrets | list | `[]` | Pull secrets to pull images from a private registry |
| image.repository | string | `"public.ecr.aws/draftt-io/draftt-explorer"` | Repository to use for the Draftt explorer |
| image.tag | string | `"0.0.1"` | Tag to use for the Draftt explorer |
| nameOverride | string | `""` | Override the chart name |
| rbac.annotations | object | `{}` | Annotations to be added to rbac resources |
| rbac.create | bool | `true` | Whether to create rbac resources <br> **Note**: When set to true, the following rbac resources will be created: <br>- cluster role <br>- cluster role binding |
| rbac.labels | object | `{}` | Labels to be added to rbac resources |
| resources.requests | object | `{"cpu":"100m","memory":"256Mi"}` | Resource requests for the draftt explorer |
| serviceAccount.annotations | object | `{}` | Annotations to be added to service account |
| serviceAccount.create | bool | `true` | Whether to create a service account. <br> **Note**: if you are using an existing service account, set this to false and provide the service account name in the name field. |
| serviceAccount.labels | object | `{}` | Labels to be added to service account |
| serviceAccount.name | string | `""` | The name of the service account. <br> If not set, and `serviceAccount.create` is true, a service account is created automatically using the fullname template. |
| serviceAccount.roleArn | string | `""` | if `appConfig.s3Mode.enabled` is true, provide an AWS IAM Role ARN for the service account with S3 access. |