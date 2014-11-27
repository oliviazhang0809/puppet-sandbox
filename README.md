# metrics

Stingray's Metrics Collection & Aggregation System. This system provides
fast, large-scale transport, storage and aggregation of metrics data
from production level services.

We're building this system out now, and we're planning to deploy it
to production to support
[userplatformserv](https://github.paypal.com/customers-r/user-platform-serv)
(UPS). We'll deploy it on a larger scale after we prove it on UPS.

# High Level Overview

The metrics project provides:

1. an infrastructure to transport sustained large amounts of metrics data
to an aggregation backend.
2. a system to run custom aggregations on the data from (1)
3. an infrastructure to view the data from (1) in near real time

# High Level Architecture

This system is composed of three major components:

1. __client side API__ - a new API that services add to their codebase
to record metrics. This API implementation sends data in
[statsd format](https://github.com/b/statsd_spec)
2. __collection daemon__ - a statsd compatible daemon that runs alongside the
CAL daemon to collect data from the API in (1)
3. __time-series database__ - the database that collects & stores data from (2).
This database is capable of running arbitrary aggregations. Currently we're
using [InfluxDB](https://github.com/influxdb/influxdb).

Please see the [Specification](./spec/SPEC.md) for more details this system.

# Test your code

This repository has code for our virtual machine based development environment. We use [Vagrant](http://vagrantup.com) to automatically and consistently build and manage VMs on each of our machines. This document comes along with [Setup instructions](SETUP.md).
