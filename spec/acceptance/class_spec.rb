require 'spec_helper_acceptance'

describe 'dm_crypt class', :if => fact('osfamily') == 'RedHat' do
#  ENV['no_proxy'] = default
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'dm_crypt': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('dm_crypt') do
      it { is_expected.to be_installed }
    end

    describe service('dm_crypt') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
