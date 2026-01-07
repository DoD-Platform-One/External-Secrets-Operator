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