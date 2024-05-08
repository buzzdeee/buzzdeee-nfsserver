# == Class: nfsserver::service
#
# Private class, do not use directly.
# Takes care about the NFS server related services.
#
class nfsserver::service {
  if ! defined(Service['portmap']) {
    include portmap
  }

  if $nfsserver::enable_lockd == true {
    service { 'lockd':
      ensure  => 'running',
      enable  => true,
      flags   => $nfsserver::lockd_flags,
      require => Service['portmap'],
    }
  }
  if $nfsserver::enable_statd == true {
    service { 'statd':
      ensure  => 'running',
      enable  => true,
      flags   => $nfsserver::statd_flags,
      require => Service['portmap'],
    }
  }
  service { 'nfsd':
    ensure  => $nfsserver::service_ensure,
    enable  => $nfsserver::service_enable,
    flags   => $nfsserver::nfsd_flags,
    require => Service['portmap'],
  }
  service { 'mountd':
    ensure  => $nfsserver::service_ensure,
    enable  => $nfsserver::service_enable,
    flags   => $nfsserver::mountd_flags,
    restart => '/usr/bin/pkill -HUP mountd',
    require => Service['portmap'],
  }
}
