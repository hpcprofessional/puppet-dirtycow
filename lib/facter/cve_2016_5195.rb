require 'puppet/util/package'

Facter.add(:cve_2016_5195) do
  confine :kernel => 'linux'

  # Set constants
  VULNERABLE     = 'vulnerable'
  NOT_VULNERABLE = 'not_vulnerable'
  UNKNOWN        = 'unknown'

  # Get facts
  MAJOR_VERSION = Facter.value(:kernelmajversion)
  VERSION       = Facter.value(:kernelversion)

  result = UNKNOWN
  case :MAJOR_VERSION
  when '4.4'
    if Puppet::Util::Package.versioncmp(VERSION, '4.4.26') == -1
      result = VULNERABLE
    else
      result = NOT_VULNERABLE
    end
  when '4.7'
    if Puppet::Util::Package.versioncmp(VERSION, '4.7.9') == -1
      result = VULNERABLE
    else
      result = NOT_VULNERABLE
    end
  when '4.8'
    if Puppet::Util::Package.versioncmp(VERSION, '4.8.26') == -1
      result = VULNERABLE
    else
      result = NOT_VULNERABLE
    end
  else
    if Puppet::Util::Package.versioncmp(VERSION, '2.6.22') == 1
      # The bug wasn't introduced until Kernel 2.6.22
      result = NOT_VULNERABLE
    elsif Puppet::Util::Package.versioncmp(MAJOR_VERSION, '4.8') == 1
      # Newer versions of the kernel should not be susceptible
      result = NOT_VULNERABLE
    else
      result = VULNERABLE
    end
  end
  result
end
