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

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module.

## Module Description

If applicable, this section should have a brief description of the technology the module integrates with and what that integration enables.
This section should answer the questions: "What does this module do?" and "Why would I use it?".

If your module has a range of functionality (installation, configuration, management, etc.) this is the time to mention it.

## Setup

The basics of getting started with this module.

### Setup Requirements

If your module requires anything extra before setting up (pluginsync enabled, etc.), mention it here.
Also mention other module dependencies.

This module requires: 
- [puppetlabs-stdlib](https://github.tooling.kpn.org/kpn-puppet-forge/puppet-puppetlabs-stdlib) (version requirement: >= 4.6.0 <5.0.0)

### What dm_crypt affects

- A list of files, packages, services, or operations that the module will alter, impact, or execute on the system it is installed on.
- This is a great place to stick any warnings.
- Can be in list or paragraph form.
  
### Beginning with dm_crypt

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps for upgrading,
you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the parameters, classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

### Parameters

This module accepts the following parameters:

#### some_regex (required)

Type: string  
Default: `undef`  
Values: any valid string containing letters or numbers.  
Description: This string is mandatory and contains an alphanumeric string.

#### some_required_param (required)

Type: string  
Default: `undef`  
Values: any valid string (not empty)  
Description: This parameter contains some string that will be used in the module.

#### some_string

Type: string  
Default: `'started'`  
Values: `'started'`, `'stopped'`  
Description: Ensures that service_status is running or stopped.

#### some_boolean

Type: boolean  
Default: `false` (RHEL5/6, windows 2008/R2), `true` (RHEL7, windows 2012/R2)  
Values: `true`, `false`  
Description: Ensures the file.txt is read-only for all users when set to true.
If set to false the file.txt will have read/write/execute permissions for everyone.

#### package_version

Type: string  
Default: `'1.0'`  
Values: any version in the repository, in format 'X.Y'  
Description: The version of the package that will be installed.

#### some_port

Type: integer  
Default: `8080`  
Values: `1 - 65535`  
Description: Sets the the port number at which the application should be accessed.
**Note:** This parameter has no effect in this module.

#### some_path

Type: string  
Default: `'C:\Temp'` (windows) or `'\tmp'`   
Values: Any accessible pathname.  
Description: A string containing the some_path filepath for the `file.txt` and `file_example.txt`.

#### some_array

Type: array of strings  
Default: `[ 'string1', 'string2' ]`  
Values: a valid array of strings  
Description: Array containing strings that should be used for something.

### Examples

#### Example 1: Minimal default installation

```puppet
  class { 'dm_crypt': 
    some_regex          => 'bla123', 
    some_required_param => 'bla,'
  }
```

#### Example 2: Setting the default values for the module

```puppet
  class { 'dm_crypt':
    some_string         => 'started',
    some_boolean        => false,
    package_version     => '1.0',
    some_port           => 8080,
    some_array          => [ 'string1', 'string2' ],
    some_regex          => 'bla123', 
    some_required_param => 'bla,'
  }
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module
so people know what the module is touching on their system but don't need to mess with things.
(We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

This module works on:
* RedHat 6
* RedHat 7
* Windows 2008 R2
* Windows 2012
* Windows 2012 R2

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
