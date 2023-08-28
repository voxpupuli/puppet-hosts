# @summary Manage /etc/hosts entries
#
# @param hosts A hash of hosts entries to manage
#
# @param default_hosts A hash of hosts entries to manage by default
#
# @param purge unmanaged host resources
#
class hosts (
  Optional[Hash[String[1], Hash[String[1], Any]]] $hosts = undef,
  Optional[Hash[String[1], Hash[String[1], Any]]] $default_hosts = undef,
  Boolean $purge = true,
) {
  $all_hosts = $hosts ? {
    undef   => $default_hosts,
    default => $default_hosts + $hosts,
  }

  if $all_hosts {
    $all_hosts.each |$n, $params| {
      host { $n:
        * => $params,
      }
    }
  }

  if $purge {
    resources { 'host':
      purge => true,
    }
  }
}
