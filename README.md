# Logging

A logging stack that is provisioned automatically using Helm. This package serves as a initial vertical slice to complement the monitoring stack for our centralized DevOps infrastructure management. Like the monitoring component, direct operational impact is minimized by collecting container logs exported to stdout on each host and shipping them to the elasticsearch cluster and hopefully is equally straightforward to setup.

The monitoring stack consists of:

Kibana - for searching and filtering log entries
FluentD - for capturing logs from cluster nodes and shipping to the central store
Elasticsearch - Used to collect and index log entries

## ElasticSearch

WARNING: This chart does  not support versions of ElasticSearch below 6.x