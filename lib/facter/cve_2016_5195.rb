require 'puppet/functions'

Facter.add(:cve_2016_5195) do
  confine :kernel => 'linux'

  vulnerable     = 'vulnerable'
  not_vulnerable = 'not_vulnerable'
  unknown        = 'unknown'

  result = unknown
  case :kernelmajversion
  when '4.4'
    if versioncmp(:kernelversion, '4.4.26') == -1
      result = vulnerable
    else
      result = not_vulnerable
    end
  when '4.7'
    if versioncmp(:kernelversion, '4.7.9') == -1
      result = vulnerable
    else
      result = not_vulnerable
    end
  when '4.8'
    if versioncmp(:kernelversion, '4.8.26') == -1
      result = vulnerable
    else
      result = not_vulnerable
    end
  else
    if versioncmp(:kernelversion, '2.6.22') == 1
      # The bug wasn't introduced until Kernel 2.6.22
      result = not_vulnerable
    elsif versioncmp(:kernelmajversion, '4.8') == 1
      # Newer versions of the kernel should not be susceptible
      result = not_vulnerable
    else
      result = vulnerable
    end
  end
  result
end
