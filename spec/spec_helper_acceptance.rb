require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'
require_relative 'spec_helper_acceptance_methods'
#require_relative 'spec_helper_acceptance_winrm.rb'

UNSUPPORTED_PLATFORMS = ['windows']

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  # Install Puppet Enterprise Agent
  run_puppet_install_helper

  # Clone module dependencies
  clone_dependent_modules
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    ## Copy hiera
    #hierarchy = [
    #  '%{facts.os.family}-%{facts.os.release.major}',
    #  'common',
    #]
    #write_hiera_config(hierarchy)
    #copy_hiera_data('./spec/fixtures/hieradata')
    puppet_module_install(:source => proj_root, :module_name => 'dm_crypt') 
    # Install dependent modules
    install_dependent_modules

    # Perform further configuration tasks here
  end
end

