{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "lexlogger.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "lexlogger.fullname" -}}
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
Create a fully qualified elasticsearch master name.
*/}}

{{- define "lexlogger.elasticsearch.master.fullname" -}}
{{- if .Values.elasticsearch.master.fullnameOverride -}}
{{- .Values.elasticsearch.master.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.elasticsearch.master.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.elasticsearch.master.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified elasticsearch data name.
*/}}

{{- define "lexlogger.elasticsearch.data.fullname" -}}
{{- if .Values.elasticsearch.data.fullnameOverride -}}
{{- .Values.elasticsearch.data.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.elasticsearch.data.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.elasticsearch.data.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified elasticsearch client name.
*/}}

{{- define "lexlogger.elasticsearch.client.fullname" -}}
{{- if .Values.elasticsearch.client.fullnameOverride -}}
{{- .Values.elasticsearch.client.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.elasticsearch.client.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.elasticsearch.client.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified fluentd name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "lexlogger.fluentd.fullname" -}}
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
Create a fully qualified fluent-bit name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "lexlogger.fluentbit.fullname" -}}
{{- if .Values.fluentbit.fullnameOverride -}}
{{- .Values.fluentbit.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.fluentbit.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.fluentbit.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified kibana name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "lexlogger.kibana.fullname" -}}
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
{{- define "lexlogger.externalDns.fullname" -}}
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
{{- define "lexlogger.networkPolicy.apiVersion" -}}
{{- if semverCompare ">=1.4-0, <1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "^1.7-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the fluentbit component
*/}}
{{- define "lexlogger.serviceAccountName.fluentbit" -}}
{{- if .Values.serviceAccounts.fluentbit.create -}}
    {{ default (include "lexlogger.fluentbit.fullname" .) .Values.serviceAccounts.fluentbit.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.fluentbit.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the kibana component
*/}}
{{- define "lexlogger.serviceAccountName.kibana" -}}
{{- if .Values.serviceAccounts.kibana.create -}}
    {{ default (include "lexlogger.kibana.fullname" .) .Values.serviceAccounts.kibana.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.kibana.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the externalDns component
*/}}
{{- define "logtstack.serviceAccountName.externalDns" -}}
{{- if .Values.serviceAccounts.externalDns.create -}}
    {{ default (include "lexlogger.externalDns.fullname" .) .Values.serviceAccounts.externalDns.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.externalDns.name }}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lexlogger.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "lexlogger.resources" -}}
limits:
  memory: {{ .Values.resourceLimits.memory }}
  cpu: {{ .Values.resourceLimits.cpu }}
requests:
  memory: {{ .Values.resourceLimits.memory }}
  cpu: {{ .Values.resourceLimits.cpu }}
{{- end -}}
