# == Class: dm_crypt

class dm_crypt (
  String         $ensure          = 'present',
  String         $package         = 'cryptsetup',
  String         $disk_device     = '/dev/sdb',
  String         $mount_point     = '/data/storage',
) {

  # call the classes that do the real work
  class { '::dm_crypt::install': 
    ensure  => $ensure,
    package => $package,
  }
  -> class { '::dm_crypt::config': 
    disk_device => $disk_device,
    mount_point => $mount_point,
  }
}
