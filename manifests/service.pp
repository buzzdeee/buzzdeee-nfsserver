# Private class, do not use directly.
# Takes care about the NFS server related services.

class nfsserver::service (
  Boolean $enable_lockd,
  Boolean $enable_statd,
  String $nfsd_flags,
  String $mountd_flags,
  String $lockd_flags,
  String $statd_flags,
  Boolean $service_enable,
  Enum[running, stopped, 'running', 'stopped'] $service_ensure,
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
