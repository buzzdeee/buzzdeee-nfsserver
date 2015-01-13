# Private class, do not use directly.
# Takes care about the exports configuration,
# and ensures that the exported directories
# exist.

class nfsserver::config (
  $exports = undef,
) {

  each ($exports) |$name, $export| {
    if (is_string($export['directory'])) {
      if (!defined(File[$export['directory']])) {
        file { $export['directory']:
          ensure => 'directory',
        }
      }
    } else {
      if (!defined(File[values_at(keys($export['directory']),0)])) {
        file { values_at(keys($export['directory']),0):
          ensure => 'directory',
          owner  => $export['directory']['owner'],
          group  => $export['directory']['group'],
          mode   => $export['directory']['mode'],
        }
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
