include_recipe 'rakam::update_ui'

bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/rakam; nohup java -Dui.directory=../rakam-ui/app -Dlog.levels-file=../log.properties -Dlog.output-file=../logs/app.log -Dlog.enable-console=false -cp $(echo rakam/target/rakam-*-bundle/rakam-*/lib/)*: org.rakam.ServiceStarter ../config.properties &'
  EOH
end
