{{/*
Return full name
*/}}
{{- define "external-secrets.fullname" -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- include "external-secrets.name" . }}  
  {{- end }}
{{- end }}  

{{/*
Return chart name
*/}}
{{- define "external-secrets.name" -}}
  {{- if .Values.nameOverride }}
    {{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}  
    {{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
  {{- end }}
{{- end }}  

{{/*
Return service account name
*/}}
{{- define "external-secrets.serviceAccountName" -}}
{{- if and (hasKey .Values "serviceAccount") (hasKey .Values.serviceAccount "create") (eq .Values.serviceAccount.create true) }}
{{- default (include "external-secrets.fullname" .) .Values.serviceAccount.name }}
{{- else if hasKey .Values "serviceAccount" }}
{{- .Values.serviceAccount.name | default "default" }}
{{- else }}
default
{{- end }}
{{- end }}

{{/*
Define namespace of chart
*/}}
{{- define "external-secrets.namespace" -}}
{{- if and (hasKey .Values "env") (hasKey .Values.env "EXTERNAL_SECRETS_NAMESPACE") }}
{{- .Values.env.EXTERNAL_SECRETS_NAMESPACE | quote }}
{{- else }}
{{- .Release.Namespace | quote }}
{{- end }}
{{- end }}

{{/*
Default labels
*/}}
{{- define "external-secrets.labels" -}}
app.kubernetes.io/name: {{ include "external-secrets.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}