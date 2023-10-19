# puppet-hosts

[![Build Status](https://github.com/voxpupuli/puppet-hosts/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-hosts/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-hosts/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-hosts/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/hosts.svg)](https://forge.puppetlabs.com/puppet/hosts)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/hosts.svg)](https://forge.puppetlabs.com/puppet/hosts)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/hosts.svg)](https://forge.puppetlabs.com/puppet/hosts)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/hosts.svg)](https://forge.puppetlabs.com/puppet/hosts)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-hosts)
[![AGPL v3 License](https://img.shields.io/github/license/voxpupuli/puppet-hosts.svg)](LICENSE)

## Table of contents

* [Usage](#hosts-setup)
  * [Examples](#examples)
* [Contributions](#contributions)
* [License and Author](#license-and-author)

## Usage

This module aims to provide default behavior which should work, without needing to set parameteres, for the majority of use cases.  That is to:

- Remove unused/uneeded/unmanaged /etc/hosts entries.
- Ensure that a typical set of entries for the loopback and related ipv6 addresses are present- Create an entry for the host's FQDN address.
- Provide an interface to create hosts entries via hiera data.

Please have a look at our [REFERENCE.md](https://github.com/voxpupuli/puppet-hosts/blob/master/REFERENCE.md). All parameters are documented in that file.

### Examples

Typically, inclusion of the `hosts` class should be sufficent for most use cases.

```puppet
include hosts
```

Creation of hosts entries via hiera:

```yaml
lookup_options:
  hosts::hosts:
    merge:
      strategy: "deep"
hosts::entries:
  foo.example.com:
    ip: '10.0.0.1'
    host_aliases:
      - foo
  bar.example.com:
    ip: '10.0.0.2'
    host_aliases:
     - bar
  baz.example.com:
    ip: '10.0.0.3'
    host_aliases:
     - baz
```

## Contributions

Contribution is fairly easy:

* Fork the module into your namespace
* Create a new branch
* Commit your bugfix or enhancement
* Write a test for it (maybe start with the test first)
* Create a pull request

Detailed instructions are in the [CONTRIBUTING.md](https://github.com/voxpupuli/puppet-hosts/blob/master/.github/CONTRIBUTING.md)
file.

## License and Author

This module was originally written by [Joshua Hoblitt](https://github.com/jhoblitt).
It's licensed with [AGPL version 3](LICENSE).
