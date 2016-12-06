# Class: dirtycow
# ===========================
#
# Full description of class dirtycow here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class dirtycow (
  $package_name = $::dirtycow::params::package_name,
  $service_name = $::dirtycow::params::service_name,
) inherits ::dirtycow::params {

  # validate parameters here

  class { '::dirtycow::install': } ->
  class { '::dirtycow::config': } ~>
  class { '::dirtycow::service': } ->
  Class['::dirtycow']
}
