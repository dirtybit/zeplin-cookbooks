node[:deploy].each do |application, deploy|
    script "npm install" do
        interpreter "bash"
        user "root"
        cwd deploy[:deploy_to]
        code <<-EOH
            "npm install"
        EOH
    end

    script "gulp release" do
        interpreter "bash"
        user "root"
        cwd deploy[:deploy_to]
        code <<-EOH
            "node ./node_modules/gulp/bin/gulp.js release"
        EOH
    end
end
