{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "draftt-k8s-explorer.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Draftt API base URL expected by the 2.0.0 agent. The existing value
may contain the legacy /component/k8s endpoint used by the 0.0.1 agent.
*/}}
{{- define "draftt-k8s-explorer.apiBaseUrl" -}}
{{- $apiURL := tpl (required "appConfig.api.drafttApiUrl is required" .Values.appConfig.api.drafttApiUrl) . -}}
{{- $apiURL = trimSuffix "/" $apiURL -}}
{{- $apiURL = trimSuffix "/component/k8s" $apiURL -}}
{{- trimSuffix "/" $apiURL -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "draftt-explorer.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ include "draftt-k8s-explorer.fullname" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{/*
The name of the service account to use
*/}}
{{- define "draftt-k8s-explorer.serviceAccountName" -}}
{{- default (include "draftt-k8s-explorer.fullname" .) .Values.serviceAccount.name -}}
{{- end -}}
