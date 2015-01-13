# Private class, do not use directly.
# The parameters that drive the module.

class nfsserver::params {
  $enable_lockd = true
  $enable_statd = true
  $nfsd_flags   = '-tun 4'
  $mountd_flags = ''
  $statd_flags  = ''
  $lockd_flags  = ''
  $service_enable = true
  $service_ensure = 'running'
}
