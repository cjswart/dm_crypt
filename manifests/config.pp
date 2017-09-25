# == Class dm_crypt::config
#
# This class is called from dm_crypt
#
class dm_crypt::config (
  $disk_device = undef,
  $mount_point = undef,
){

  # Make this a private class
  assert_private("Use of private class ${name} by ${caller_module_name} not allowed.")

  case "${facts['os']['family']}${facts['os']['release']['full']}" {
    /RedHat(6|7)/: {
      file { '/apps':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }
    }
    default: { 
      fail("Module dm_crypt is not supported on ${::facts['os']['osfamily']}${::facts['os']['release']['full']}") 
    }
  }
}
