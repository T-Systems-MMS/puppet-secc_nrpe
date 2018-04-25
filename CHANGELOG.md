# 2.1.1
## Added
* CHANGELOG.md (keep me up-to-date ;))

## Fixed
* ASC-282 - `/etc/sudoers.d/nrpe` had `nrpe` hardcoded as user
  * Changing the value for `::secc_nrpe::nrpe_user` would have caused a useless sudo rule
