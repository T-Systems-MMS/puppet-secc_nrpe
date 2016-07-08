# AMCS SecC - NRPE Module

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

* Für die Grundfunktionalität von NRPE muss die Main Class inkludiert werden.

## Usage

* nrpe.cfg wird in '/etc/nagios/' abgelegt
* nrpe wird in /etc/sudoers.d/ abgelegt (Sollte der NRPE User Checks als Root ausführen müssen, muss der Parameter nrpe_must_be_root = true gesetzt werden.)
* sollte 127.0.0.1 mit also allowed_host in der nrpe.cfg auftauchen muss setlocalhost = true sein
* wenn eine andere IP Adresse als eth0 oder enp0s3 als server_address in der nrpe.cfg gewünscht ist, muss  diese in server_address = [undef] definiert werden
* Defaultparameter:
	* $epelreponame         = 'epel',
	* $server_address       = [undef],
	* $setServerAddress     = true,
	* $setlocalhost         = false,
	* $server_port          = "5666",
	* $allowed_hosts        = ["172.29.70.2"],
	* $nrpe_user            = "nrpe",
	* $nrpe_group           = "nrpe",
	* $nrpe_must_be_root    = false,
	* $admininterface_xen0  = 'xenbr0',
	* $admininterface_nr    = '0', 
* Wenn server_address nicht definiert ist, wird die IP des Standard Interfaces als server_address gesetzt.
* Das Modul kann via Puppetfile eingebunden werden.
* Der SSL Handshake kann mit dem Kommando /usr/lib64/nagios/plugins/check_nrpe <IP> überprüft werden (Ergbnis NRPEvXX)

## Usage ohne Puppet

* Eine Copy&Paste Übernahme in Projekte sollte möglich sein, wurde aber nicht getestet.

## Reference

1. Classes
    * secc_nrpe
    * secc_nrpe::user
    * secc_nrpe::install
    * secc_nrpe::config
    * secc_nrpe::permissions
    * secc_nrpe::service

## Limitations

* Modul wurde erfolgreich gegen CentOS6, CentOS7, RHEL6, RHEL7 getestet.

## Development

* Änderungen am Modul sollten auch im Serverspec amcs_secc_nrpe_spec.rb nachgezogen werden.

## Release Notes/Contributors/Etc

* Initialrelease.
* 1.0.1 Fix Installation with install_options enablerepo
