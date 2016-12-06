# == Class dirtycow::service
#
# This class is meant to be called from dirtycow.
# It ensure the service is running.
#
class dirtycow::service {

  service { $::dirtycow::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
