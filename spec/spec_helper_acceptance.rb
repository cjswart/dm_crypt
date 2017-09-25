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
    # create a virtual block device for beaker test
    # create a 100M file in /opt
    shell('dd if=/dev/zero of=/opt/sdb-backstore bs=1M count=100')

    # create the loopback block device
    # where 7 is the major number of loop device driver, grep loop /proc/devices
    shell('mknod /dev/sdb b 7 200')
    shell('losetup /dev/sdb  /opt/sdb-backstore')

    # create certificates for test
    shell('openssl genpkey -algorithm RSA  -out /etc/puppetlabs/puppet/ssl/private_keys/`hostname`.pem -pkeyopt rsa_keygen_bits:2048')
    shell('openssl rsa -pubout -in /etc/puppetlabs/puppet/ssl/private_keys/`hostname`.pem -out /etc/puppetlabs/puppet/ssl/public_keys/`hostname`.pem')
    shell('echo --- > /etc/facter/facts.d/secret.yaml')
    shell('echo -n "encrypted_secret: " >> /etc/facter/facts.d/secret.yaml')
    shell('< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-64} | openssl rsautl -encrypt -inkey /etc/puppetlabs/puppet/ssl/public_keys/`hostname`.pem -pubin | base64 | tr -d "\n" >>/etc/facter/facts.d/secret.yaml')
 
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

