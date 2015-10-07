template "/var/www/config.properties" do
  source "config.properties.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/var/www/log.properties" do
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

include_recipe "rakam_ui::service"

service "rakam_ui" do
  action [ :enable, :start ]
end
