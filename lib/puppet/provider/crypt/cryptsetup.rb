Puppet::Type.type(:crypt).provide(:cryptsetup) do
  commands :cryptsetup => "/usr/sbin/cryptsetup"
  commands :mount      => "/usr/bin/mount"
#  options = []
#    (options << '--verbose --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random luksFormat')
#    (options << "#{resource[:device]}")
  def password
    execute("echo #{resource[:password]}| base64 -d | openssl rsautl -decrypt -inkey /etc/puppetlabs/puppet/ssl/private_keys/`hostname`.pem")
  end
  def exists?
    begin
      execute("echo #{password}|/usr/sbin/cryptsetup luksDump --dump-master-key #{resource[:device]}")
    rescue Puppet::ExecutionFailure => e
      false
    end
  end
  def create
    options = "--verbose --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5 --use-random luksFormat #{resource[:device]}"
    execute("echo #{password}|/usr/sbin/cryptsetup #{options}")
  end
  def destroy
  end
  def device
    return resource[:device] if system("/usr/sbin/cryptsetup -v status #{resource[:name]}")
  end
  def device=(value)
    system("echo #{password}|/usr/sbin/cryptsetup open --type luks #{resource[:device]} #{resource[:name]}")
  end
  def filesystem_type
    return resource[:filesystem_type] if system("blkid /dev/mapper/#{resource[:name]}")
  end
  def filesystem_type=(value)
    mkfs('-t', "#{resource[:filesystem_type]}", "/dev/mapper/#{resource[:name]}")
  end
  def mount_point
  end
  def mount_point=(value)
    mount("/dev/mapper/#{resource[:name]}", "#{resource[:mount_point]}")
  end
end

