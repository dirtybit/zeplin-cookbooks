node[:deploy].each do |application, deploy|
    script "npm and gulp" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"
        case node[:opsworks][:stack][:name]
        when 'zeplin-dev-stack'
            code <<-EOH
                npm install && NODE_ENV=dev node ./node_modules/gulp/bin/gulp.js release
            EOH
        when 'zeplin-prod-stack'
            code <<-EOH
                npm install && NODE_ENV=prod node ./node_modules/gulp/bin/gulp.js release
            EOH
        end
    end
end
