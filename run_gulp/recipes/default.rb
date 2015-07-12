node[:deploy].each do |application, deploy|
    if deploy[:application_type] != 'static'
        Chef::Log.debug("Skipping deploy::web application #{application} as it is not an static HTML app")
        next
    end

    script "run npm tasks" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"

        if node[:opsworks][:stack][:name].start_with?("zeplin-dev")
            code <<-EOH
                npm install
                NODE_ENV=dev npm start
            EOH
        elsif node[:opsworks][:stack][:name].start_with?("zeplin-prod")
            code <<-EOH
                npm install
                NODE_ENV=prod npm start
            EOH
        else
            throw("invalid environment")
        end
    end
end
