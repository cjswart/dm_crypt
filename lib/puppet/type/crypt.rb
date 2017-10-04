Puppet::Type.newtype(:crypt) do
  desc <<-EOT
    Ensures that an given device is fully encrypted and not readable if unmounted and closed.
    Example:
    crypt { 'postgressDB':
      ensure      => present,
      name        => 'postgressDB',
      device      => '/dev/sdb',
      moint_point => '/apps/postgressDB',
      password    => 'secret',
    }
  EOT
  validate do
    fail('device is required when ensure is present') if self[:ensure] == :present and self[:device].nil?
  end 
  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the label for this device.'
  end

  newproperty(:device) do
    desc 'The device to be encrypted.'
    validate do |value|
      unless Pathname.new(value).absolute?
        fail("Invalid device #(value)")
      end
    end
  end
  newproperty(:filesystem_type) do
    desc 'The filesystem type for this device.'
    newvalues(:xfs, :ext4)
  end
  newproperty(:mount_point) do
    desc 'Mount point for the encrypted device.'
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
