# Logging

A logging stack that is provisioned automatically using Helm. This package serves as a initial vertical slice to complement the monitoring stack for our centralized DevOps infrastructure management. Like the monitoring component, direct operational impact is minimized by collecting container logs exported to stdout on each host and shipping them to the elasticsearch cluster and hopefully is equally straightforward to setup.

The monitoring stack consists of:

Kibana - for searching and filtering log entries
FluentD - for capturing logs from cluster nodes and shipping to the central store
Elasticsearch - Used to collect and index log entries

## ElasticSearch

WARNING: This chart does  not support versions of ElasticSearch below 6.x

## Kibana

On instantiation of the app stack, you will need to create an initial search index in the Kibana UI and select a time field to key off of.

## FluentD

FluentD is included as the aggregator only in this chart, with a set number of pods being managed by a deployment. This optimizes the ability to use FluentD to perform necessary operations on log messages and ship them to ElasticSearch without the overhead of running FluentD as a daemonset across the entire cluster.

## Fluent-Bit

To maintain the ability to ship logs from all containers across the cluster to the central ElasticSearch repository by way of FluentD but without the excess overhead of replicating FluentD across the entire cluster, the much lighter weight Fluent-Bit is used as a simple log shipper with the additional option to collect metrics from the Fluent-Bit pods in complement to a Prometheus stack.