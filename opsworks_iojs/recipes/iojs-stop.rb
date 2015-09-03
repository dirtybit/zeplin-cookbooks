node[:deploy].each do |application, deploy|
  if application != 'zeplin_preview'
    Chef::Log.info("Skipping deploy::iojs-stop for application #{application} as it is not zeplin-preview app")
    next
  end

  ruby_block "stop io.js application #{application}" do
    block do
      Chef::Log.info("stop io.js via: #{node[:deploy][application][:nodejs][:stop_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:stop_command]}`)
      $? == 0
    end
  end

end
