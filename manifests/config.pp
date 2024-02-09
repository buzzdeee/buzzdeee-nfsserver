# Private class, do not use directly.
# Takes care about the exports configuration,
# and ensures that the exported directories
# exist.

class nfsserver::config (
  Hash $exports = undef,
) {

  each ($exports) |$name, $export| {
    $exportdir = values_at(keys($export['directory']),0)
    if !defined(File["${exportdir}"]) {
      file { $exportdir:
        ensure => 'directory',
        owner  => $export['directory']['owner'],
        group  => $export['directory']['group'],
        mode   => $export['directory']['mode'],
      }
    }
  }

  file { '/etc/exports':
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => template('nfsserver/exports.erb'),
  }
}
