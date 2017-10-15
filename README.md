# dm_crypt

| Beaker | RSpec | Syntax |
|:-:|:-:|:-:|
| [![Build Status](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_4_acceptance/badge/icon)](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_4_acceptance/) | [![Build Status](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_3_unit/badge/icon)](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_3_unit/) | [![Build Status](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_2_syntax/badge/icon)](https://jenkins.tooling.kpn.org:8443/job/module/job/kpn-dm_crypt/job/kpn-dm_crypt_2_syntax/) |

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Setup requirements](#setup-requirements)
    * [What dm_crypt affects](#what-dm_crypt-affects)
    * [Beginning with dm_crypt](#beginning-with-dm_crypt)
4. [Usage](#usage)
    * [Parameters](#parameters)
    * [Examples](#examples)
5. [Reference](#reference)
6. [Limitations](#limitations)
7. [Development](#development)

## Overview

This module will create a encrypted partion for a device using dm-crypt cryptsetup.
Be very carefull to keep you secret otherwise your data is never accessable again.

## Module Description 

This module creates an encrypted partion on a disk device with the executable cryptsetup.
You need to specify the disk device which will be encrypted.
You need to specitfy the mount point to mount the encrypted partition.
You need to specify the filesystem type to format the encrypted partition.
You need to supply a base64 encrypted password based on the puppet agent certificates.

## Setup 


### Setup  Requirements

This module requires: 
- [puppetlabs-stdlib](https://github.tooling.kpn.org/kpn-puppet-forge/puppet-puppetlabs-stdlib) (version requirement: >= 4.6.0 <5.0.0)


### What dm_crypt affects

- The package cryptsetup will be installed.
- The directory path of the suplied mountpoint will be created.
- cryptsetup is used to create the encrypted luks device with a key based on the supplied password.
- cryptsetup will open de the device with a label (label will be the last directory of the supplied mountpoint).
- mkfs will format de newly created encrypted partion /dev/mapper/<label>.
- the new device will be mounted on the suplied mountpoint.

You have to supply a base64 encrypted password based on the puppet agents certificates to create the partion.
Keep this password on a safe place because it is needed to open and mount the device otherwise you're data is never accessable again.
For example creating a base64 encrypted password based on de puppet agent public key:
echo "my secret passphrase" | openssl rsautl -encrypt -inkey /etc/puppetlabs/puppet/ssl/public_keys/`hostname`.pem -pubin | base64 | tr -d "\n"
  
### Beginning with dm_crypt

## Usage

### Parameters

This module accepts the following parameters:

  String         $disk_device,
  String         $mount_point,
  String         $filesystem_type,
  String         $password        = $::encrypted_secret,
  String         $ensure          = 'present',
  String         $package         = 'cryptsetup',

#### disk_device (required)
Type: string  
Default: `undef`  
Values: any valid string representing a existing disk device for example /dev/sdb 
Description: This parameter contains a tring with the disk device used for the encrypted partition

#### mount_point (required)
Type: string  
Default: `undef`  
Values: any valid string with a valid abslotu path of the mount point where the encrypted partion will be mounted 
Description: This parameter contains the mount point an the last directory of the path will be used as the label for the encrypted luks device

#### filesytem_type (required)
Type: Enum[string]  
Default: `undef`  
Values: 'ext4' or 'xfs' 
Description: This parameter contains the filesystem type for mkfs to format the new encrypted partion.

#### password (required)
type: string
Default: `undef`  
Values: base64 encrypted string based on the puppet agent certificates
Description: This parameter contains the encrypted password in base64 format encryption based on the puppet agent certificates
you can supply this password as external fact encrypted_secret

#### ensure 

Type: string  
Default: `'present'`
Values: `'present'`, `'absent'`  
Description: Ensures that  resource will be created or removed.
Be carefull to remove the resource because any data on the encrypted partition will be lost

#### package

Type: string  
Default: `'cryptsetup'`  
Values: any velis sting with the coreect package name  
Description: The package that will be installed.

### Examples

#### Example 1: Setting the default values for the module

```puppet
  class { 'dm_crypt':
    ensure          => 'present',
    disk_device     => '/dev/sdb',
    mount_point     => '/apps/postgresDB',
    filesystem_type => 'ext4',
    password        => $::encrypted_secret,
  }  
```

## Reference
classes:
* dm_crypt::init
* dm_crypt::install
* dm_crypt::config
types:
* lib/puppet/type/crypt.rb
providers:
* lib/puppet/providers/crypt/rhel7.rb
* lib/puppet/providers/crypt/rhel6.rb

## Limitat ions

This module works only on:
* RedHat 6
* RedHat 7

## Development 

You can contribute by submitting issues, providing feedback and joining the discussions.

Go to: `https://github.tooling.kpn.org/kpn-puppet-forge/dm_crypt`

If you want to fix bugs, add new features etc:
- Fork it
- Create a feature branch ( git checkout -b my-new-feature )
- Apply your changes and update rspec tests
- Run rspec tests ( bundle exec rake spec )
- Commit your changes ( git commit -am 'Added some feature' )
- Push to the branch ( git push origin my-new-feature )
- Create new Pull Request
