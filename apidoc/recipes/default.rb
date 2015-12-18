node[:deploy].each do |application, deploy|
    if deploy[:application_type] != 'nodejs'
        Chef::Log.debug("Skipping deploy::application #{application} as it is not a node.js app")
        next
    end

    script "generate apidoc" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"

        code <<-EOH
            npm install -g grunt-cli
            npm install grunt grunt-apidoc
            grunt
            chown #{deploy[:user]}:#{deploy[:group]} apidoc
        EOH
    end
end
