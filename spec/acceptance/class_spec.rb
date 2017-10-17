require 'spec_helper_acceptance'

describe 'dm_crypt', :if => fact('os.family') == 'RedHat' do
  context 'remove dmcrypt if present' do
    describe 'should first uninstall package, when present' do
      if fact('os.release.major') == "6"
        removepp = <<-EOS
      package { 'cryptsetup-luks':
        ensure => absent,
      }
        EOS
      else
        removepp = <<-EOS
      package { 'cryptsetup':
        ensure => absent,
      }
        EOS
      end
      # Run it twice and test for idempotency
      apply_manifest(removepp, :catch_failures => true)
      apply_manifest(removepp, :catch_changes  => true)
      if fact('os.release.major') == "6"
        describe 'should uninstall the cryptsetup package' do
          describe package('cryptsetup-luks') do
             it { is_expected.to_not be_installed }
          end
        end
      else
        describe 'should uninstall the cryptsetup-luks package' do
          describe package('cryptsetup') do
             it { is_expected.to_not be_installed }
          end
        end
      end
    end
  end

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'dm_crypt':
        config_ensure   => 'present',
        disk_device     => '/dev/sdb',
        mount_point     => '/apps/postgresDB',
        filesystem_type => 'ext4',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end
    if fact('os.release.major') == "6"
      describe 'is_expected.to install the cryptsetup-luks package' do
        describe package('cryptsetup-luks') do
          it { is_expected.to be_installed }
        end
      end
    else
      describe 'should install the cryptsetup package' do
        describe package('cryptsetup') do
          it { is_expected.to be_installed }
        end
      end
    end
  end
  context 'remove encrypted partition' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'dm_crypt':
        config_ensure   => 'absent',
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
