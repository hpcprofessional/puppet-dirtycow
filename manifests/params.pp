# == Class dirtycow::params
#
# This class is meant to be called from dirtycow.
# It sets variables according to platform.
#
class dirtycow::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'dirtycow'
      $service_name = 'dirtycow'
    }
    'RedHat', 'Amazon': {
      $package_name = 'dirtycow'
      $service_name = 'dirtycow'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
