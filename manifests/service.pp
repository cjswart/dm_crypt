# == Class dm_crypt::service
#
# This class is called from dm_crypt
#
class dm_crypt::service {

  # Make this a private class
  assert_private("Use of private class ${name} by ${caller_module_name} not allowed.")

  #  $service_name = $::dm_crypt::params::service_name
  #  $some_string  = $::dm_crypt::some_string
  #
  #  service { 'dm_crypt_service':
  #    ensure => $some_string,
  #    enable => true,
  #    name   => $service_name,
  #  }
}
