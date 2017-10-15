Puppet::Type.type(:crypt).provide(:rhel6) do
  # Without initvars commands won't work.
  initvars

  # Make sure we find mysql commands on CentOS and FreeBSD
  ENV['PATH'] = ENV['PATH'] + ':/usr/bin:/usr/sbin:/bin:/sbin'

  confine :osfamily => :redhat
  confine :operatingsystemmajrelease => 6
  commands :cryptsetup => "cryptsetup"
  commands :mkfs       => "mkfs"
  commands :mount      => "mount"
  commands :umount     => "umount"
  def password
    execute("echo #{resource[:password]}| base64 -d | openssl rsautl -decrypt -inkey /etc/puppetlabs/puppet/ssl/private_keys/`hostname`.pem")
  end
  def exists?
    begin
      execute("echo #{password}|cryptsetup luksDump --dump-master-key #{resource[:disk_device]}")
      true
    rescue Puppet::ExecutionFailure => e
      false
    end
  end
  def create
    options = "--verbose --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 luksFormat #{resource[:disk_device]}"
    execute("echo #{password}|cryptsetup #{options}")
    system("echo #{password}|cryptsetup luksOpen #{resource[:disk_device]} #{resource[:name]}")
    if !system("blkid /dev/mapper/#{resource[:name]} ")
      mkfs('-t', "#{resource[:filesystem_type]}", "/dev/mapper/#{resource[:name]}")
    end
    mount("/dev/mapper/#{resource[:name]}", "#{resource[:mount_point]}")
  end
  def destroy
    umount("/dev/mapper/#{resource[:name]}")
    cryptsetup('-v', 'luksClose', "/dev/mapper/#{resource[:name]}")
    system("echo #{password}|cryptsetup luksRemoveKey #{resource[:disk_device]}")
  end
  def mount_point
    if !system("cryptsetup -v status /dev/mapper/#{resource[:name]} > /dev/null 2>&1")
      return false
    else
      return resource[:mount_point] if system("mountpoint #{resource[:mount_point]} > /dev/null 2>&1")
    end
  end
  def mount_point=(value)
    system("echo #{password}|cryptsetup luksOpen #{resource[:disk_device]} #{resource[:name]}")
    mount("/dev/mapper/#{resource[:name]}", "#{resource[:mount_point]}")
  end
end

