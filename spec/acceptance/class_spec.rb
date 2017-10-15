require 'spec_helper_acceptance'

describe 'dm_crypt class', :if => fact('osfamily') == 'RedHat' do
#  ENV['no_proxy'] = default
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'dm_crypt':
        ensure          => 'present',
        disk_device     => '/dev/sdb',
	mount_point     => '/apps/postgresDB',
	filesystem_type => 'ext4',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end
    if fact('operatingsystemmajrelease') == '6'
      describe 'should install the correct packages' do
        describe package('cryptsetup-luks') do
          it { should be_installed }
        end
      end
    end
    if fact('operatingsystemmajrelease') == '7'
      describe 'should install the correct packages' do
        describe package('cryptsetup') do
          it { should be_installed }
        end
      end
    end
  end
  context 'remove encrypted partition' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'dm_crypt':
        ensure          => 'absent',
        disk_device     => '/dev/sdb',
	mount_point     => '/apps/postgresDB',
	filesystem_type => 'ext4',
      }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end
  end
end
