# AMCS SecC - NRPE Module

[![Build Status](https://travis-ci.org/T-Systems-MMS/puppet-secc_nrpe.svg?branch=master)](https://travis-ci.org/T-Systems-MMS/puppet-secc_nrpe)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [nrpe]](#setup)
    * [What [nrpe] affects](#what-[nrpe]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [nrpe]](#beginning-with-[nrpe])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## :warning: Deprecated

This module is deprecated an will no longer be maintained or updated.
If you still need the functionality, we suggest you use [pdxcat-nrpe](https://forge.puppet.com/modules/pdxcat/nrpe) and apply a hardened configuration.

## Overview

This module provides a partial coverage of the SoC conditions for NRPE under Linux.

## Module Description

This module installs and configures NRPE on a Linux system. Further it will define a separate `nrpe` user and create sudo rules in `/etc/sudoers.d/nrpe`,

## Setup

### What [nrpe] affects

1. Templates
    * '/etc/nagios/nrpe.cfg'
    * '/etc/sudoers.d/nrpe'
1. Packages
    * 'nrpe' (EPEL Repo has to be installed. Default for reponame is 'epel'.)
    * 'nagios-plugins-nrpe' (check_nrpe -> Test of SSL handshake)
1. Services
    * 'nrpe' (The service will be restarted on configuration changes.)
1. User / Groups
    * 'nrpe'
    * 'nagios'

### Beginning with [nrpe]

* for base configuration include the class `secc_nrpe`
* sudo has to be installed beforehand

## Usage

* `nrpe.cfg` is placed in `/etc/nagios/`
* `nrpe` is placed in `/etc/sudoers.d/` 
* if the NRPE user should  run checks as root, set `nrpe_must_be_root = true`
* `127.0.0.1` and `172.29.70.2` are default `allowed_hosts` in `nrpe.cfg`
* if further `allowed_hosts` are needed, these can be specified in a list, eg. `allowed_hosts => ['127.0.0.1', '192.168.0.1']`
* if `server_address`is unspecified, the default IP (puppet-fact `ipaddress`) is used
* the SSL handshake can be checked with `/usr/lib64/nagios/plugins/check_nrpe <IP>` (Expected result: NRPEvXX)

## Reference

1. Classes
    * `secc_nrpe`
    * `secc_nrpe::user`
    * `secc_nrpe::install`
    * `secc_nrpe::config`
    * `secc_nrpe::permissions`
    * `secc_nrpe::service`

## Limitations

* This module was tested with CentOS6 and CentOS7

## Development

* Please document changes within the module using git commits
* Execution of tests: `bundler install`, `bundler exec rake`
