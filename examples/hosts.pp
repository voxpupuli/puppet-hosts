class { 'hosts':
  hosts => {
    'foo.example.com' => {
      ip           => '10.0.0.1',
      host_aliases => ['foo'],
    },
    'bar.example.com' => {
      ip           => '10.0.0.2',
      host_aliases => ['bar'],
    },
    'baz.example.com' => {
      ip           => '10.0.0.3',
      host_aliases => ['baz'],
    },
  },
}
