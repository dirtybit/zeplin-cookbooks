include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if application != 'zeplin_preview'
    Chef::Log.debug("Skipping deploy::iojs-undeploy for application #{application} as it is not a zeplin-preview app")
    next
  end

  ruby_block "stop io.js application #{application}" do
    block do
      Chef::Log.info("stop io.js via: #{node[:deploy][application][:nodejs][:stop_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:stop_command]}`)
      $? == 0
    end
  end

  file "#{node[:monit][:conf_dir]}/node_web_app-#{application}.monitrc" do
    action :delete
    only_if do
      ::File.exists?("#{node[:monit][:conf_dir]}/node_web_app-#{application}.monitrc")
    end
  end

  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete

    only_if do
      ::File.exists?("#{deploy[:deploy_to]}")
    end
  end
end
