# draftt-port-integration

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for Draftt - Port.io integration

## Installing the Chart

To install the draftt-port-integration chart:

    helm install draftt-port-integration draftt-io/draftt-port-integration

To uninstall the chart:

    helm uninstall draftt-port-integration

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appConfig.draftt.drafttApiToken | object | `{"secretKey":"drafttApiToken","secretName":"draftt-port-integration"}` | The draftt API token secret. A k8s generic secret should be created according to the draftt port integration setup instructions. <br> **Note**: Make sure the secret is created in the same namespace as the draftt port integration and the secret name and key are as specified in the values.yaml file. |
| appConfig.draftt.drafttApiToken.secretKey | string | `"drafttApiToken"` | The key of the secret |
| appConfig.draftt.drafttApiToken.secretName | string | `"draftt-port-integration"` | The name of the secret |
| appConfig.draftt.drafttApiUrl | string | `"https://api.draftt.io/v1"` | The draftt API URL |
| appConfig.namespace | string | `"monitoring"` | The namespace that all resources will be deployed on |
| appConfig.port.baseUrl | string | `"https://api.getport.io"` | The port.io base URL |
| appConfig.port.eventListenerType | string | `"POLLING"` | The port.io event listener type |
| appConfig.port.identifier | string | `"draftt-io"` | The draftt port integration identifier |
| appConfig.port.initializePortResources | string | `"true"` | Whether to initialize port.io resources |
| appConfig.port.portClientId | object | `{"secretKey":"portClientId","secretName":"draftt-port-integration"}` | The port.io client ID secret |
| appConfig.port.portClientSecret | object | `{"secretKey":"portClientSecret","secretName":"draftt-port-integration"}` | The port.io client secret |
| commonLabels | object | `{}` | Common labels to be added to all resources |
| deployment.affinity | object | `{}` | Affinity for the deployment |
| deployment.annotations | object | `{}` | Annotations to be added to the deployment |
| deployment.labels | object | `{}` | Labels to be added to the deployment |
| deployment.nodeSelector | object | `{}` | Node selector for the deployment |
| deployment.resources | object | `{"requests":{"cpu":"100m","memory":"256Mi"}}` | Resources configuration |
| deployment.resources.requests | object | `{"cpu":"100m","memory":"256Mi"}` | Resource requests for the deployment |
| deployment.restartPolicy | string | `"Always"` | The restart policy for the deployment pod |
| deployment.tolerations | list | `[]` | Tolerations for the deployment |
| image.pullPolicy | string | `"Always"` | Image pull policy to use for the Draftt port integration |
| image.pullSecrets | list | `[]` | Pull secrets to pull images from a private registry |
| image.repository | string | `"public.ecr.aws/draftt-io/draftt-port-integration"` | Repository to use for the Draftt port integration |
| image.tag | string | `"0.0.1"` | Tag to use for the Draftt port integration |
| nameOverride | string | `""` | Override the chart name |