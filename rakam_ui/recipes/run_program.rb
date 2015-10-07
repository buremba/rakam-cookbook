template "/home/webapp/config.properties" do
  source "config.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0644
end

template "/home/webapp/log.properties" do
  source "log.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0644
end

bash "download and build package" do
  user "webapp"
  cwd "home/webapp"
  environment ({ 'HOME' => ::Dir.home("webapp"), 'USER' => "webapp" })
  code <<-EOH
    git clone https://github.com/buremba/rakam.git
    cd rakam && mvn clean install -DskipTests -Pbundled-with-ui -Pmove-package-to-dependency
  EOH
end

bash "run program" do
  user "webapp"
  cwd "home/webapp"
  environment ({ 'HOME' => ::Dir.home("webapp"), 'USER' => "webapp" })
  code <<-EOH
    cd /home/webapp/rakam && nohup java -Dhttp.server.address=0.0.0.0:5000 -Dlog.levels-file=../log.properties -Dlog.output-file=../logs/app.log -Dlog.enable-console=false -cp rakam/target/dependency/*: org.rakam.ServiceStarter ../config.properties &
  EOH
end
