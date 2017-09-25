require 'spec_helper'

describe 'dm_crypt' do

  default_params = {
    'ensure'       => 'present',
    'package'      => 'cryptsetup',
    'disk_device'  => '/dev/sdb',
    'mount_point'  => '/data/storage',
  }

  UNSUPPORTED_FACTS.each do |facts|
    describe "on unsupported operating system #{facts['os']['family']} #{facts['os']['release']['major']}" do
      let(:params) { {} }
      let(:facts) { facts }
#      it { is_expected.to raise_error(Puppet::Error, /Module dm_crypt is not supported on #{facts['os']['family']} #{facts['os']['release']['major']}/) }
       it { should raise_error(Puppet::Error, /Module dm_crypt is not supported/) }
    end
  end

  SUPPORTED_FACTS.each do |facts|
    describe "on supported operating system #{facts['os']['family']} #{facts['os']['release']['major']}" do
      let(:facts) { facts }

      describe 'without parameters' do
        let(:params) { {} }

        it { is_expected.to compile.with_all_deps }
      end

      describe "with default parameters" do
        let(:params) { default_params }
        it { is_expected.to compile.with_all_deps }

        # Check classes and relations
        it { is_expected.to contain_class('dm_crypt') }
        it { is_expected.to contain_class('dm_crypt::install') }
        it { is_expected.to contain_class('dm_crypt::config') }

        # Check common resources
        it { is_expected.to contain_file('/apps').with(
          'ensure' => 'directory',
          'owner'  => 'root',
          'group'  => 'root',
	  'mode'   => '0755',
        )
        }
        it { is_expected.to contain_package('cryptsetup') }
      end
    end
  end
end
