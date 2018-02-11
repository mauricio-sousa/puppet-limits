class limits::params {
  $ensure             = present
  $hard               = undef
  $soft               = undef
  $purge_limits_d_dir = false

  case $::osfamily {
    'Debian','RedHat': {
      $limits_dir = '/etc/security/limits.d/'
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }
}