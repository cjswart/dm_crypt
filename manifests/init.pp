# == Class: dm_crypt

class dm_crypt (
  String         $disk_device,
  String         $mount_point,
  String         $filesystem_type,
  String         $ensure          = 'present',
  String         $package         = 'cryptsetup',
) {

  # call the classes that do the real work
  class { '::dm_crypt::install': 
    ensure  => 'present',
    package => $package,
  }
  -> class { '::dm_crypt::config': 
    ensure          => $ensure,
    disk_device     => $disk_device,
    mount_point     => $mount_point,
    filesystem_type => $filesystem_type,
  }
}
