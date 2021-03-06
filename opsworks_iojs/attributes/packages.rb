include_attribute 'opsworks_iojs::default'
include_attribute 'opsworks_iojs::repo'

case node['nodejs']['engine']
when 'node'
  default['nodejs']['packages'] = value_for_platform_family(
    'debian' => node['nodejs']['install_repo'] ? ['nodejs'] : ['nodejs', 'npm', 'nodejs-dev'],
    ['rhel', 'fedora'] => ['nodejs', 'nodejs-devel', 'npm'],
    'mac_os_x' => ['node'],
    'default' => ['nodejs']
  )
when 'iojs'
  default['nodejs']['packages'] = ['iojs']
end
