{{/*
Expand the name of the chart.
*/}}
{{- define "postgresRclone.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgresRclone.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "postgresRclone.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgresRclone.labels" -}}
helm.sh/chart: {{ include "postgresRclone.chart" . }}
{{ include "postgresRclone.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgresRclone.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postgresRclone.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgresRclone.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "postgresRclone.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "postgresRclone.configmap.init" -}}
{{ include "postgresRclone.fullname" . }}-init
{{- end }}

{{- define "postgresRclone.configmap.backup" -}}
{{ include "postgresRclone.fullname" . }}-backup
{{- end }}

{{- define "postgresRclone.configmap.entrypoint" -}}
{{ include "postgresRclone.fullname" . }}-entrypoint
{{- end }}

{{- define "postgresRclone.secret.rclone.conf" -}}
{{ include "postgresRclone.fullname" . }}-rclone-conf
{{- end }}

{{- define "postgresRclone.secret.superuser.password" -}}
{{ include "postgresRclone.fullname" . }}-superuser-password
{{- end }}

{{- define "postgresRclone.service.main" -}}
{{ include "postgresRclone.fullname" . }}-main
{{- end }}

{{- define "postgresRclone.dirname" -}}
{{ .Release.Namespace }}/{{ include "postgresRclone.fullname" . }}
{{- end }}

{{- define "postgresRclone.test.backup" -}}
{{ include "postgresRclone.fullname" . }}-backup-test
{{- end }}

{{- define "postgresRclone.test.pgbench" -}}
{{ include "postgresRclone.fullname" . }}-pgbench-test
{{- end }}
