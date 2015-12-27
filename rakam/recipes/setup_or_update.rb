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
    cd /home/webapp
    su webapp -l -c 'if cd rakam; then git pull; else git clone https://github.com/buremba/rakam.git && cd rakam; fi'
    su webapp -l -c 'cd rakam; mvn clean install -DskipTests && cd rakam/target; tar -zxvf *-bundle.tar.gz'
  EOH
end
