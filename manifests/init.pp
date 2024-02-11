# == Class: nfsserver
#
# This class manages the nfssserver
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
#   Hash: describes the exports lines going into /etc/exports.
#
# === Variables
#
# === Examples
#
#  class { nfsserver:
#    exports => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
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
  Hash $exports = undef,
) {
  class { 'nfsserver::config':
    exports => $exports,
  }

  class { 'nfsserver::service':
    enable_lockd   => $enable_lockd,
    enable_statd   => $enable_statd,
    nfsd_flags     => $nfsd_flags,
    mountd_flags   => $mountd_flags,
    statd_flags    => $statd_flags,
    lockd_flags    => $lockd_flags,
    service_enable => $service_enable,
    service_ensure => $service_ensure,
  }

  Class['nfsserver::config']
  ~> Class['nfsserver::service']
}
