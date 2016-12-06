require 'spec_helper'

describe 'dirtycow' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "dirtycow class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('dirtycow::params') }
          it { is_expected.to contain_class('dirtycow::install').that_comes_before('dirtycow::config') }
          it { is_expected.to contain_class('dirtycow::config') }
          it { is_expected.to contain_class('dirtycow::service').that_subscribes_to('dirtycow::config') }

          it { is_expected.to contain_service('dirtycow') }
          it { is_expected.to contain_package('dirtycow').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'dirtycow class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('dirtycow') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
