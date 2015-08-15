# Override the engine to iojs
default['nodejs']['engine'] = 'iojs'

# Override the version to 3.0.0
default['nodejs']['version'] = '3.0.0'

# Override the repo
case node['platform_family']
when 'debian'
  default['nodejs']['repo'] = 'https://deb.nodesource.com/iojs_3.x'
end

default["nodebin"]["location"] = '/usr/bin/nodejs'
default["nodebin"]["opsworks_location"] = '/usr/local/bin/node'
