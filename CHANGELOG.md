# Changelog

## [UNRELEASED]

## [3.1.0] - 2019-08-27
### Added
* make command_timeout configurable

## [3.0.0] - 2018-09-19
### Added
* set merge behavior for nrpe_custom_root
* set parameters with in module hiera 5
* jwt gem
* datatypes for parameters in init.pp

### Removed
* params.pp
* Puppet 3 support
* parameter define_nrpe_custom_root


## [2.1.1] - 2018-07-18
### Added
* initial public release
* CHANGELOG.md (keep me up-to-date ;))

### Fixed
* ASC-282 - `/etc/sudoers.d/nrpe` had `nrpe` hardcoded as user
  * Changing the value for `::secc_nrpe::nrpe_user` would have caused a useless sudo rule
