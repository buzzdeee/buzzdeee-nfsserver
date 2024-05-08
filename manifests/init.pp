# == Class: nfsserver
#
# This class manages the nfsd, mountd, lockd, and statd.
#
# === Parameters
#
# [*enable_lockd*]
#   Boolean: whether to enable lockd, default: true
#
# [*enable_statd*]
#   Boolean: whether to enable statd, default: true
#
# [*nfsd_flags*]
#   String: nfsd service flags, default: '-tun 4'
#
# [*mountd_flags*]
#   String: mountd service flags, default: ''
#
# [*statd_flags*]
#   String: statd service flags, default: ''
#
# [*lockd_flags*]
#   String: lockd service flags, default: ''
#
# [*service_enable*]
#   Boolean: Wether to enable the service, default: true
#
# [*service_ensure*]
#   Enum[running, stopped]: The desired service state, default: 'running'
#
# [*exports*]
#   Optional Hash: describes the exports lines going into /etc/exports.
#
# === Variables
#
# === Examples
#
# In the very simplest case, you just include the following:
#
# include nfsserver
#
# Configuration example for Hiera:
#
# nfsserver::exports:
#   export_node1:
#     directory:
#       /export/node1:
#         owner: 'root'
#         group: '0'
#         mode: '0755'
#     exportparams: '-ro -maproot=root:wheel'
#     clients: "-network=192.168.0 -mask=255.255.255.0"
#
# consult man exports(5) for details about parameters.
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Sebastian Reitenbach, unless otherwise noted.
#
class nfsserver (
  Boolean $enable_lockd,
  Boolean $enable_statd,
  String $nfsd_flags,
  String $mountd_flags,
  String $statd_flags,
  String $lockd_flags,
  Boolean $service_enable,
  Enum[running, stopped, 'running', 'stopped'] $service_ensure,
  Optional[Hash] $exports,
) {
  contain nfsserver::config
  contain nfsserver::service

  Class['nfsserver::config']
  ~> Class['nfsserver::service']
}
