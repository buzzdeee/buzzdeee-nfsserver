# Private class, do not use directly.
# Takes care about the NFS server related services.

class nfsserver::service (
  Bool $enable_lockd,
  Bool $enable_statd,
  String $nfsd_flags,
  String $mountd_flags,
  String $lockd_flags,
  String $statd_flags,
  Bool $service_enable,
  Bool $service_ensure,
) {

  if ! defined(Service['portmap']) {
    include portmap
  }

  if $enable_lockd == true {
    service { 'lockd':
      ensure  => 'running',
      enable  => true,
      flags   => $lockd_flags,
      require => Service['portmap'],
    }
  }
  if $enable_statd == true {
    service { 'statd':
      ensure  => 'running',
      enable  => true,
      flags   => $statd_flags,
      require => Service['portmap'],
    }
  }
  service { 'nfsd':
    ensure  => $service_ensure,
    enable  => $service_enable,
    flags   => $nfsd_flags,
    require => Service['portmap'],
  }
  service { 'mountd':
    ensure  => $service_ensure,
    enable  => $service_enable,
    flags   => $mountd_flags,
    restart => '/usr/bin/pkill -HUP mountd',
    require => Service['portmap'],
  }
}
