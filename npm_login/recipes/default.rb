node[:deploy].each do |application, deploy|
    script "npm login" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"

        application_environment_file do
            user deploy[:user]
            group deploy[:group]
            path ::File.join(deploy[:deploy_to], "shared")
            environment_variables deploy[:environment_variables]
        end

        code <<-EOH
            set -o nounset
            set -o errexit

            npm login <<!
            $NPM_USERNAME
            $NPM_PASSWORD
            $NPM_EMAIL
		    !
        EOH
    end
end
