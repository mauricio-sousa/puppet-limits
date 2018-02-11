# Class: A module for manage files in /etc/security/limits.d
#
#
class limits(
  $purge_limits_d_dir = $limits::params::purge_limits_d_dir,
) inherits limits::params {
  file { $limits::params::limits_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    force   => true,
    purge   => $purge_limits_d_dir,
    recurse => true,
  }
}