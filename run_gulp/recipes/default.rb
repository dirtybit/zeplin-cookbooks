node[:deploy].each do |application, deploy|
    if deploy[:application_type] != 'static'
        Chef::Log.debug("Skipping deploy::web application #{application} as it is not an static HTML app")
        next
    end

    script "run npm tasks" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"
        case node[:opsworks][:stack][:name]
        when 'zeplin-dev-stack'
            code <<-EOH
                npm install
                NODE_ENV=dev npm start
            EOH
        when 'zeplin-prod-stack'
            code <<-EOH
                npm install
                NODE_ENV=prod npm start
            EOH
        end
    end
end
