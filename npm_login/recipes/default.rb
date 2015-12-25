node[:deploy].each do |application, deploy|
    script "npm login" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"

        code <<-EOH
            set -o nounset
            set -o errexit

            npm login <<!
            #{deploy[:deploy]['zeplin-backend'][:environment_variables][:NPM_USERNAME]} 
            #{deploy[:deploy]['zeplin-backend'][:environment_variables][:NPM_PASSWORD]} 
            #{deploy[:deploy]['zeplin-backend'][:environment_variables][:NPM_EMAIL]} 
            !
        EOH
    end
end
