# Changelog

## [UNRELEASED]

## [2.1.1] - 2018-07-18
### Added
* initial public release
* CHANGELOG.md (keep me up-to-date ;))

### Fixed
* ASC-282 - `/etc/sudoers.d/nrpe` had `nrpe` hardcoded as user
  * Changing the value for `::secc_nrpe::nrpe_user` would have caused a useless sudo rule
