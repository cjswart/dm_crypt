Puppet::Type.newtype(:crypt_init) do
  desc <<-EOT
    Creates an fully encrypted Luks partition.
    Example:
    crypt_init { 'postgressDB':
      ensure      => present,
      name        => 'postgressDB',
      disk_device => '/dev/sdb',
      password    => 'secret',
    }
  EOT
  validate do
    fail('disk_device is required when ensure is present') if self[:ensure] == :present and self[:disk_device].nil?
  end
  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the label for this device.'
  end

  newproperty(:disk_device) do
    desc 'The device to be encrypted.'
    validate do |value|
      unless Pathname.new(value).absolute?
        fail("Invalid device #(value)")
      end
    end
  end

  newparam(:password) do
    desc 'Password to create and open the encrypted device'
  end

end
