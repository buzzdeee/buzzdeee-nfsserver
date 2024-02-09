# == Class: nfsserver
#
# Full description of class nfsserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nfsserver:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@openbsd.org>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class nfsserver (
  Boolean $enable_lockd,
  Boolean $enable_statd,
  String $nfsd_flags,
  String $mountd_flags,
  String $statd_flags,
  String $lockd_flags,
  Boolean $service_enable,
  Boolean $service_ensure,
  Hash $exports = undef,
) inherits nfsserver::params {

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

  Class['nfsserver::config'] ~>
  Class['nfsserver::service']

}
