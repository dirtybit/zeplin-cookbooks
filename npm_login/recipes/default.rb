node[:deploy].each do |application, deploy|
    script "npm login" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"

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
