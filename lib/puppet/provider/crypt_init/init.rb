Puppet::Type.type(:crypt_init).provide(:init) do
  # Without initvars commands won't work.
  initvars

  # Make sure we find mysql commands on CentOS and FreeBSD
  ENV['PATH'] = ENV['PATH'] + ':/usr/bin:/usr/sbin:/bin:/sbin'

  confine :osfamily => :redhat
  commands :cryptsetup => "cryptsetup"
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
    execute("echo #{password}|/usr/sbin/cryptsetup #{options}")
    system("echo #{password}|cryptsetup open --type luks #{resource[:disk_device]} #{resource[:name]}")
  end
  def destroy
    execute("echo #{password}|cryptsetup erase #{resource[:disk_device]}")
  end
  def disk_device
    return resource[:disk_device] if system("cryptsetup -v status /dev/mapper/#{resource[:name]}")
  end
  def disk_device=(value)
    system("echo #{password}|cryptsetup open --type luks #{resource[:disk_device]} #{resource[:name]}")
  end
end

