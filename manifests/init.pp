# @summary Manage /etc/hosts entries
#
# @param hosts A hash of hosts entries to manage
#
class hosts (
  Optional[Hash[String[1], Hash[String[1], Any]]] $hosts = undef,
) {
  if $hosts {
    $hosts.each |$name, $params| {
      host { $name:
        * => $params,
      }
    }
  }
}
