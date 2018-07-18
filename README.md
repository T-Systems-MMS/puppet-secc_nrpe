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

## Overview

Diese Modul installiert und konfiguriert den NRPE Service.

## Module Description

Das Modul installiert NRPE und rollt die NRPE Konfiguration aus. Darüber hinaus definiert es den zu nutzenden User (nrpe) und legt ein nrpe-File in /etc/sudoers.d/ an.

## Setup

### What [nrpe] affects

1. Templates
    * '/etc/nagios/nrpe.cfg'
    * '/etc/sudoers.d/nrpe'
1. Packages
    * 'nrpe' (EPEL Repo muss vorhanden sein. Defaultwert für den Reponame ist 'epel'.)
    * 'nagios-plugins-nrpe' (check_nrpe -> Test des SSL Handshakes)
1. Services
    * 'nrpe' (Der Service wird neugestartet wenn sich Konfigurtionen ändern.)
1. User / Gruppen
    * 'nrpe'
    * 'nagios'

### Beginning with [nrpe]

* Für die Grundfunktionalität von NRPE muss die Main Class inkludiert werden, sowie sudo installiert sein.

## Usage

* nrpe.cfg wird in '/etc/nagios/' abgelegt
* nrpe wird in /etc/sudoers.d/ abgelegt (Sollte der NRPE User Checks als Root ausführen müssen, muss der Parameter nrpe_must_be_root = true gesetzt werden.)
* `127.0.0.1` und `172.29.70.2` wird standardmaessig als `allowed_hosts` in der nrpe.cfg eingetragen
* sollen weitere Hosts in die `allowed_hosts` eingetragen werden, muss dies in einer Liste geschehen, z.B. ``allowed_hosts  => ['127.0.0.1', '192.168.0.1']
* Wenn server_address nicht definiert ist, wird die IP des Standard Interfaces (puppet-fact `ipaddress`) als server_address gesetzt
* Das Modul kann via Puppetfile eingebunden werden.
* Der SSL Handshake kann mit dem Kommando /usr/lib64/nagios/plugins/check_nrpe <IP> überprüft werden (Ergbnis NRPEvXX)

## Reference

1. Classes
    * secc_nrpe
    * secc_nrpe::user
    * secc_nrpe::install
    * secc_nrpe::config
    * secc_nrpe::permissions
    * secc_nrpe::service

## Limitations

* Modul wurde erfolgreich gegen CentOS6, CentOS7 getestet.

## Development

* Änderungen am Modul sollten auch im Serverspec amcs_secc_nrpe_spec.rb nachgezogen werden.
