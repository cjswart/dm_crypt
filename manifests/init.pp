# == Class: dm_crypt

class dm_crypt (
  String         $ensure          = 'present',
  String         $package_name    = 'cryptsetup',
  String         $disk_device     = '/dev/sdb',
  String         $mount_point     = '/data/storage',
) {

  # call the classes that do the real work
  class { '::dm_crypt::install': 
    ensure       => $ensure,
    package_name => $package_name,
  }
  -> class { '::dm_crypt::config': 
    disk_device => $disk_device,
    mount_point => $mount_point,
  }
  ~> class { '::dm_crypt::service': }
}
