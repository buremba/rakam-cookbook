template "/var/www" do
  source "config.properties.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/var/www" do
  source "log.properties.erb"
  owner "root"
  group "root"
  mode 0644
end

bash "download and build package" do
  code <<-EOH
    cd /var/www
    git clone git@github.com:buremba/rakam.git
    cd rakam && mvn clean install -DskipTests -Pbundled-with-ui -Pmove-package-to-dependency
  EOH
end

bash "run program" do
  code <<-EOH
    nohup java -Dhttp.server.address=0.0.0.0:5000 -Dlog.levels-file=log.properties -Dlog.output-file=logs/app.log -Dlog.enable-console=false -cp rakam/target/dependency/*: org.rakam.ServiceStarter config.properties &
  EOH
end
