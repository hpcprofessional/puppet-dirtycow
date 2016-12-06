# Class: dirtycow
# ===========================
#
# Notifies the administrator if the system if vulnerable to CVE-2016-5195, also
# known as "Dirty COW".
#
# Parameters
# ----------
#
# * `notify_behavior`
#   This parameter determines what type of notification happens. The default is
#   simply to create a notification message. However, the adminstrator can set
#   it to fail catalog compilation, if so desired.
#
class dirtycow (
  $notify_behavior = $::dirtycow::params::notify_behavior,
) inherits ::dirtycow::params {

  $bad_behavior = "Invalid value for \$::dirtycow::notify_behavior: ${notify_behavior}"

  unless $notify_behavior in [ 'fail', 'notify'] {
    fail($bad_behavior)
  }

  $vulnurable_message = @(VMESSAGE)
                        This system is vulnerable to CVE-2016-5195, also knwon as "Dirty COW".
                        See http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-5195
                        and https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-5195
                        for further information.
                        |-VMESSAGE
  $unknown_message    = @(UMESSAGE)
                        It could not be determined if this system is vulnerable to CVE-2016-5195,
                        also known as "Dirty COW". Manual intervention is requested.
                        See http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-5195
                        and https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-5195
                        for further information.
                        |-UMESSAGE

  if $::kernel == 'Linux' {
    message = $::cve_2016_5195 ? {
      'vulnerable' => $vulnerable_message,
      'unknown'    => $unknown_message,
      default      => undef,
    }
    if $message {
      case $notify_behavior {
        'fail':   {
                    fail($message)
                  }
         'notify': {
                    notice { 'CVE-2016-5195':
                      message => $message,
                    }
                  }
         default:  {
                    # We should never get here
                    fail($bad_behavior)
                  }
      }
    }
  }

}
