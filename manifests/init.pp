# @summary Manage /etc/hosts entries
#
# @param entries A hash of hosts entries to manage
#
# @param default_entries A hash of hosts entries to manage by default
#
# @param purge unmanaged host resources
#
# @param manage_fqdn manage the fqdn entry
#
class hosts (
  Hash[String[1], Hash[String[1], Any]] $entries = {},
  Hash[String[1], Hash[String[1], Any]] $default_entries = {},
  Boolean $purge = true,
  Boolean $manage_fqdn = true,
) {
  $all_hosts = $default_entries + $entries

  $all_hosts.each |$n, $params| {
    host { $n:
      * => $params,
    }
  }

  if $purge {
    resources { 'host':
      purge => true,
    }
  }

  if $manage_fqdn {
    host { $facts['networking']['fqdn']:
      ensure       => present,
      ip           => $facts['networking']['ip'],
      host_aliases => $facts['networking']['hostname'],
    }
  }
}
