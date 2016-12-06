require 'puppet/util/package'

Facter.add(:cve_2016_5195) do
  confine :kernel => 'Linux'
  setcode do
    kernel_major_version = Facter.value('kernelmajversion')
    kernel_version       = Facter.value('kernelversion')
    result               = :unknown
    case kernel_major_version
    when '4.4'
      if Puppet::Util::Package.versioncmp(kernel_version, '4.4.26') == -1
        result = :vulnerable
      else
        result = :not_vulnerable
      end
    when '4.7'
      if Puppet::Util::Package.versioncmp(kernel_version, '4.7.9') == -1
        result = :vulnerable
      else
        result = :not_vulnerable
      end
    when '4.8'
      if Puppet::Util::Package.versioncmp(kernel_version, '4.8.26') == -1
        result = :vulnerable
      else
        result = :not_vulnerable
      end
    else
      if Puppet::Util::Package.versioncmp(kernel_version, '2.6.22') < 0
        # The bug wasn't introduced until Kernel 2.6.22
        result = :not_vulnerable
      elsif Puppet::Util::Package.versioncmp(kernel_major_version, '4.8') == 1
        # Newer versions of the kernel should not be susceptible
        result = :not_vulnerable
      else
        result = :vulnerable
      end
    end
    result
  end
end
