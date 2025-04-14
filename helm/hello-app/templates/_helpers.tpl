{{- define "helloapp.name" -}}
{{- default "hello-app" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Helm required labels */}}
{{- define "helloapp.labels" -}}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}
app: "{{ template "helloapp.name" . }}"
{{- end -}}

{{/* matchLabels */}}
{{- define "helloapp.matchLabels" -}}
release: {{ .Release.Name }}
app: "{{ template "helloapp.name" . }}"
{{- end -}}