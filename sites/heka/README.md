#Heka

####Table of Contents

1. [Overview - What is the hekad module?](#overview)
2. [Module Description - What does this module do?](#module-description)
3. [Setup - The basics of getting started with hekad](#setup)
4. [Usage - The class and available configurations](#usage)
5. [Contributing to the hekad module](#contributing)

##Overview

This module installs and configures for heka.

##Module Description

[Heka](https://hekad.readthedocs.org/en/v0.8.0/) is an open source stream processing software system developed by Mozilla. It can be using for loading and parsing log files, taking statsd type metrics data for aggregation and forwarding to upstream time series data stores such as graphite or InfluxDB, etc.

This puppet module is used to install, configure and create heka daemon so as to streamline the process of using heka with Puppet. 

##Setup

**What heka affects:**

* dowloads/installs/configures files for Heka

###Beginning with Heka

Install Heka with default parameters. In this case heka will be 
installed at /opt/hekad.

##Usage

####Class: `hekad`

This is the primary class. And the only one which should be used.

**Parameters within `heka`:**

#####`version`

Version of heka to be installed.
Default is '0.8.0'

#####`config_path`

Configuration file `config.toml` location.

#####`exec_path`

`init.sh` location.

Rest params are associated with heka - please check [Configuring hekad](https://hekad.readthedocs.org/en/v0.8.0/config/index.html), [Inputs](https://hekad.readthedocs.org/en/v0.8.0/config/inputs/) and [Decoders](https://hekad.readthedocs.org/en/v0.8.0/config/decoders/index.html).

##Limitations

This module is tested on CentOS 6.5 and should also run without problems on

* RHEL/CentOS/Scientific 6+
* Debian 6+
* Ubunutu 10.04 and newer

##Contributing

This module is open projects. So if you want to make this module even better, you can contribute to this module on [Github](https://github.com/oliviazhang0809/puppet-hekad).
