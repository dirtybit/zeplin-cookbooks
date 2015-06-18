node[:deploy].each do |application, deploy|
    script "npm and gulp" do
        interpreter "bash"
        user "root"
        cwd "#{deploy[:deploy_to]}/current"
        code <<-EOH
            npm install
            node ./node_modules/gulp/bin/gulp.js release
        EOH
    end
end
