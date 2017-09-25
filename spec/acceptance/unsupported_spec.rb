require 'spec_helper_acceptance'

describe 'unsupported distributions and OSes', :if => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should fail' do
    pp = <<-EOS
    class { 'dm_crypt': }
    EOS
    expect(apply_manifest(pp, :expect_failures => true).stderr).to match(/is not supported/i)
  end
end