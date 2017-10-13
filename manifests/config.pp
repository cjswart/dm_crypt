# == Class dm_crypt::config
#
# This class is called from dm_crypt
#
class dm_crypt::config (
  $ensure          = present,
  $disk_device     = undef,
  $filesystem_type = undef,
  $mount_point     = undef,
){

  # Make this a private class
  assert_private("Use of private class ${name} by ${caller_module_name} not allowed.")

  case "${facts['os']['family']}${facts['os']['release']['full']}" {
    /RedHat(6|7)/: {
     # Create directory tree from $mount_point
     $mount_point.split('/').reduce |$memo, $value| {
        notice("${memo}/${value}")
        file { "${memo}/${value}":
          ensure => 'directory',
          owner   => 'root',
          group   => 'root',
          mode    => '0755',
        }
        "${memo}/${value}"
      }
      # get label name from directory name without the complete path
      if $mount_point =~ /(.*\/)(.*.)/ {
        $base_path = $1
        $label = $2
      }
      # Configure crypt luks partition 
      crypt_init { $label:
        ensure          => $ensure,
        password        => $::encrypted_secret,
        name            => $label,
        disk_device     => $disk_device,
      }
      # Configure crypt luks partition 
      crypt_mount { $label:
        ensure          => $ensure,
        name            => $label,
        filesystem_type => $filesystem_type,
        mount_point     => $mount_point,
      }
    }
    default: {
      fail("Module dm_crypt is not supported on ${::facts['os']['osfamily']}${::facts['os']['release']['full']}")
    }
  }
}

