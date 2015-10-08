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

include_recipe "nodejs::npm"

bash "download and build package" do
  code <<-EOH
    su webapp
    cd /home/webapp
    if cd rakam; then git pull; else git clone https://github.com/buremba/rakam.git && cd rakam; fi
    mvn clean install -DskipTests -Pmove-package-to-dependency
  EOH
end

bash "download and build ui" do
  code <<-EOH
    su webapp
    cd /home/webapp
    if cd rakam-ui; then git pull; else git clone https://github.com/buremba/rakam-ui.git && cd rakam-ui; fi
    npm install
  EOH
end

bash "run program" do
  code <<-EOH
    su webapp
    cd /home/webapp
    nohup java -Dhttp.server.address=0.0.0.0:5000 -Dui.directory=../rakam-ui -Dlog.levels-file=../log.properties -Dlog.output-file=../logs/app.log -Dlog.enable-console=false -cp rakam/target/dependency/*: org.rakam.ServiceStarter ../config.properties &
  EOH
end
