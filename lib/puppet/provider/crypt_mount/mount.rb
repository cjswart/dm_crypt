Puppet::Type.type(:crypt_mount).provide(:mount) do
  # Without initvars commands won't work.
  initvars

  # Make sure we find mysql commands on CentOS and FreeBSD
  ENV['PATH'] = ENV['PATH'] + ':/usr/bin:/usr/sbin:/bin:/sbin'

  confine :osfamily => :redhat
  commands :mkfs       => "mkfs"
  commands :mount      => "mount"
  commands :umount     => "umount"
  commands :cryptsetup => "cryptsetup"
  def exists?
    begin
      cryptsetup('-v', 'status', "/dev/mapper/#{resource[:name]}")
      true
    rescue Puppet::ExecutionFailure => e
      false
    end
  end
  def create
    fail("failure no open luks partition with label #{resource[:name]}")
  end
  def destroy
    umount("/dev/mapper/#{resource[:name]}")
    cryptsetup('-v', 'close', "/dev/mapper/#{resource[:name]}")
  end
  def filesystem_type
    return resource[:filesystem_type] if system("blkid /dev/mapper/#{resource[:name]} ")
  end
  def filesystem_type=(value)
    mkfs('-t', "#{resource[:filesystem_type]}", "/dev/mapper/#{resource[:name]}")
  end
  def mount_point
    return resource[:mount_point] if system("mountpoint #{resource[:mount_point]} > /dev/null 2>&1")
  end
  def mount_point=(value)
    mount("/dev/mapper/#{resource[:name]}", "#{resource[:mount_point]}")
  end
end

