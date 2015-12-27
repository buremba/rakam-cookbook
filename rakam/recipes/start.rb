include_recipe 'rakam::update_ui'

bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/rakam; nohup java -Dhttp.server.address=0.0.0.0:5000 -Dui.directory=../rakam-ui/app -Dlog.levels-file=../log.properties -Dlog.output-file=../logs/app.log -Dlog.enable-console=false -cp rakam/target/rakam-*/lib/*: org.rakam.ServiceStarter ../config.properties &'
  EOH
end