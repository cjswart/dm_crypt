require 'puppetlabs_spec_helper/module_spec_helper'

SUPPORTED_FACTS = [
  { 'os' => {
      'name' => 'CentOs',
      'family' => 'RedHat',
      'release' => {
        'major' => '7',
        'minor' => '2',
        'full' => '7.2.1511',
      },
    },
  },
  { 'os' => {
      'name' => 'CentOs',
      'family' => 'RedHat',
      'release' => {
        'major' => '6',
        'minor' => '3',
        'full' => '6.3.834',
      },
    },
  },
]

UNSUPPORTED_FACTS = [
  { 'os' => {
      'name' => 'windows',
      'family' => 'windows',
      'release' => {
        'major' => '2012 R2',
        'minor' => '2012',
        'full' => '2012 R2',
      },
    },
  },
]

RSpec.configure do |c|
  c.fail_fast = true
  c.before :each do
    # Prevent 'fact "clientversion" already has the maximum number of resolutions allowed (100).' error
    Facter.clear
  end

end

at_exit { RSpec::Puppet::Coverage.report! }
