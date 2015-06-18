
node[:deploy].each do |application, deploy|
    script "install_something" do
        interpreter "bash"
        user "root"
        cwd deploy[:deploy_to]
        code <<-EOH
            "./node_modules/gulp/bin/gulp.js release"
        EOH
    end
end
