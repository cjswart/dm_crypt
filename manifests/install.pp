# == Class dm_crypt::install
#
# This class is called from dm_crypt
#
class dm_crypt::install (
  $ensure       = 'present',
  $package      = 'cryptsetup',
){

  # Make this a private class
  assert_private("Use of private class ${name} by ${caller_module_name} not allowed.")

  package { $package:
    ensure => $ensure,
    name   => $package,
  }
}
