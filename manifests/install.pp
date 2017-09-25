# == Class dm_crypt::install
#
# This class is called from dm_crypt
#
class dm_crypt::install (
  $ensure       = 'present',
  $package_name = 'cryptsetup',
){

  # Make this a private class
  assert_private("Use of private class ${name} by ${caller_module_name} not allowed.")

  package { 'dm_crypt_package':
    ensure => $ensure,
    name   => $package_name,
  }
}
