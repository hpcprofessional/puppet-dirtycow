# == Class dirtycow::install
#
# This class is called from dirtycow for install.
#
class dirtycow::install {

  package { $::dirtycow::package_name:
    ensure => present,
  }
}
