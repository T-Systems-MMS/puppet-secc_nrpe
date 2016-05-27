# nrpe

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

## Overview

This module installs, configures and starts NRPE.
It provides all check scripts and global permissions (for monitoring).

## Module Description

NRPE is used to remotely execute scripts on a server running it, so your monitoring solution (e.g. Nagios) can check things, that cannot be read from 'the outside'.
The module covers everything that needs to be done to run NRPE.

## Setup

### What [nrpe] affects

1. Files
    * '/home/nrpe/bin/'
        * currently set to 'remote' > the module will ensure presence of files known but will not delete additional files
    * '/etc/nagios/nrpe.cfg'
    * '/etc/nrpe.d/'
        * **WARNING**: Configurations that are NOT managed by Puppet will be purged
    * '/etc/nrpe.d/general.cfg'
    * '/etc/sudoers.d/nrpe'
1. Packages
    * 'nrpe' ( requires EPEL to be accessible )
1. Services
    * 'nrpe' ( will be restarted on configuration change )
1. User / Gruppen
    * 'nrpe'

### Setup Requirements **OPTIONAL**

* 'yum' must be able to install the package 'nrpe' without '--enablerepo'

### Beginning with [nrpe]

* For basic NRPE functionality simply include the main class

## Usage

* new check scripts to be stored under '/home/nrpe/bin/' go in 'files/home/nrpe/bin/'
* when adding a NRPE configuration file under '/etc/nrpe.d/' from within another module be sure to require the main class and notify the service class
    * ```
    require => Class['nrpe'],
    notify  => Class['nrpe::service'],
    ```

## Reference

1. Classes
    * nrpe
    * nrpe::user
    * nrpe::install
    * nrpe::config
    * nrpe::permissions
    * nrpe::service
1. Facts

## Limitations
## Development
## Release Notes/Contributors/Etc **Optional**
