{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "logstack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "logstack.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified elasticsearch name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "logstack.elasticsearch.fullname" -}}
{{- if .Values.elasticsearch.fullnameOverride -}}
{{- .Values.elasticsearch.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.elasticsearch.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.elasticsearch.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified fluentd name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "logstack.fluentd.fullname" -}}
{{- if .Values.fluentd.fullnameOverride -}}
{{- .Values.fluentd.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.fluentd.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.fluentd.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified kibana name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "logstack.kibana.fullname" -}}
{{- if .Values.kibana.fullnameOverride -}}
{{- .Values.kibana.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.kibana.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.kibana.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified externalDns name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "logstack.externalDns.fullname" -}}
{{- if .Values.externalDns.fullnameOverride -}}
{{- .Values.externalDns.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.externalDns.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.externalDns.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "logstack.networkPolicy.apiVersion" -}}
{{- if semverCompare ">=1.4-0, <1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "^1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the elasticsearch component
*/}}
{{- define "logstack.serviceAccountName.elasticsearch" -}}
{{- if .Values.serviceAccounts.elasticsearch.create -}}
    {{ default (include "logstack.elasticsearch.fullname" .) .Values.serviceAccounts.elasticsearch.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.elasticsearch.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the fluentd component
*/}}
{{- define "logstack.serviceAccountName.fluentd" -}}
{{- if .Values.serviceAccounts.fluentd.create -}}
    {{ default (include "logstack.fluentd.fullname" .) .Values.serviceAccounts.fluentd.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.fluentd.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the kibana component
*/}}
{{- define "logstack.serviceAccountName.kibana" -}}
{{- if .Values.serviceAccounts.kibana.create -}}
    {{ default (include "logstack.kibana.fullname" .) .Values.serviceAccounts.kibana.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.kibana.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the externalDns component
*/}}
{{- define "logtstack.serviceAccountName.externalDns" -}}
{{- if .Values.serviceAccounts.externalDns.create -}}
    {{ default (include "logstack.externalDns.fullname" .) .Values.serviceAccounts.externalDns.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.externalDns.name }}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "logstack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "logstack.resources" -}}
limits:
  memory: {{ .Values.resourceLimits.memory }}
  cpu: {{ .Values.resourceLimits.cpu }}
requests:
  memory: {{ .Values.resourceLimits.memory }}
  cpu: {{ .Values.resourceLimits.cpu }}
{{- end -}}
