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
Create the Kubernetes catalog cronjob name.
*/}}
{{- define "draftt-k8s-explorer.catalogFullname" -}}
{{- printf "%s-catalog" ((include "draftt-k8s-explorer.fullname" .) | trunc 55 | trimSuffix "-") -}}
{{- end -}}

{{/*
Return the shared Draftt API base URL. The default keeps upgrades rendered with
pre-2.0.0 reused values compatible even when the new value is absent.
*/}}
{{- define "draftt-k8s-explorer.apiBaseUrl" -}}
{{- trimSuffix "/" (tpl (default "https://api.draftt.io" .Values.appConfig.api.baseUrl) .) -}}
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
Kubernetes catalog labels use the independently configured catalog image tag.
*/}}
{{- define "draftt-explorer.catalogLabels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ include "draftt-k8s-explorer.fullname" . }}
app.kubernetes.io/component: catalog
app.kubernetes.io/version: {{ .Values.catalogCronJob.image.tag | quote }}
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
