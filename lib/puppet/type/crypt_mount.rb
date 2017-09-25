Puppet::Type.newtype(:crypt_mount) do
  desc <<-EOT
    Ensures that an given encrypted Luks partition is formatted and mounted.
    Example:
    crypt_mount { 'postgressDB':
      ensure           => present,
      name             => 'postgressDB',
      filesystem_type  => 'ext4',
      disk_device      => '/dev/sdb',
      moint_point      => '/apps/postgressDB',
    }
  EOT
  validate do
    fail('mount_point is required when ensure is present') if self[:ensure] == :present and self[:mount_point].nil?
  end
  ensurable do
    defaultvalues
    defaultto :present
  end
  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the label for this device.'
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
end
