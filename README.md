[![Ruby CI](https://github.com/mauricio-sousa/puppet-limits/actions/workflows/ruby.yml/badge.svg)](https://github.com/mauricio-sousa/puppet-limits/actions/workflows/ruby.yml)

Manage user and group limits via Puppet

This module manages the limits.

## How to use

```puppet
class { 'limits': }

limits::limit { 'username_nofile':
  ensure     => present,
  user       => 'username',
  limit_type => {
    nofile  => {
      soft => 16384,
      hard => 32768,
    }
  }
}

```
### Purge limits.d directory explicit

```puppet
class { 'limits':
  purge_limits_d_dir => true,
}

limits::limit { 'username_nofile':
  ensure     => present,
  user       => 'username',
  limit_type => {
    nofile  => {
      soft => 16384,
      hard => 32768,
    }
  }
}
```

### Set multiple limit types

```puppet
class { 'limits': }

limits::limit { 'username_nofile':
  ensure     => present,
  user       => 'username',
  limit_type => {
    nofile => {
      soft => 16384,
      hard => 32768,
    },
    nproc  => {
      soft => 16384,
      hard => 32768,
    },
    core   => {
      soft => 16384,
      hard => 32768,
    }
  }
}
```
### Set group limit types

```puppet
class { 'limits': }

limits::limit { 'username_nofile':
  ensure     => present,
  user       => '@groupname',
  limit_type => {
    nofile  => {
      soft => 16384,
      hard => 32768,
    }
  }
}
```
