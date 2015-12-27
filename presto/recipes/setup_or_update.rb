directory "/home/webapp/presto" do
  owner "webapp"
  group "webapp"
  mode 0755
end

directory "/home/webapp/presto/plugin" do
  owner "webapp"
  group "webapp"
  mode 0755
end
directory "/home/webapp/presto/plugin/presto-rakam-streaming" do
  owner "webapp"
  group "webapp"
  mode 0755
end
directory "/home/webapp/presto/plugin/presto-rakam-raptor" do
  owner "webapp"
  group "webapp"
  mode 0755
end

directory "/home/webapp/presto/etc" do
  owner "webapp"
  group "webapp"
  mode 0755
end
directory "/home/webapp/presto/etc/catalog" do
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/config.properties" do
  source "config.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/node.properties" do
  source "node.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/jvm.config" do
  source "jvm.config.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/log.properties" do
  source "log.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end


template "/home/webapp/presto/etc/catalog/middleware.properties" do
  source "catalog/middleware.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/catalog/rakam_raptor.properties" do
  source "catalog/rakam_raptor.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end


template "/home/webapp/presto/etc/catalog/streaming.properties" do
  source "catalog/streaming.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

directory "/home/webapp/.ssh" do
  owner "webapp"
  group "webapp"
  mode 0755
end
template "/home/webapp/.ssh/rakam_streaming" do
  source "keys/rakam_streaming/rakam_streaming"
  owner "webapp"
  group "webapp"
  mode 0600
end
template "/home/webapp/.ssh/rakam_raptor" do
  source "keys/rakam_raptor/rakam_raptor"
  owner "webapp"
  group "webapp"
  mode 0600
end

presto_download_address = "https://repo1.maven.org/maven2/com/facebook/presto/presto-server/#{node['presto_version']}/presto-server-#{node['presto_version']}.tar.gz"

bash "download-and-setup-presto" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'wget -N #{presto_download_address}'
	  su webapp -l -c 'tar -zxvf presto-server-*.tar.gz'
    su webapp -l -c 'rm -rf presto/bin && cp -r presto-server-*/bin/ presto/'
    su webapp -l -c 'rm -rf presto/lib && cp -r presto-server-*/lib/ presto/'
    su webapp -l -c 'if cd presto-rakam-streaming; then ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_streaming; git pull"; else ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_streaming; git clone git@github.com:buremba/presto-rakam-streaming.git" && cd presto-rakam-streaming; fi'
    su webapp -l -c 'cd presto-rakam-streaming; mvn clean install -DskipTests -Dair.check.skip-checkstyle=true -Dair.check.skip-license=true; mv target/presto-rakam-*/* ../presto/plugin/presto-rakam-streaming'
    su webapp -l -c 'if cd presto-rakam-raptor; then ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_raptor; git pull"; else ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_raptor; git clone git@github.com:buremba/presto-rakam-raptor.git" && cd presto-rakam-raptor; fi'
    su webapp -l -c 'cd presto-rakam-raptor; mvn clean install -DskipTests -Dair.check.skip-checkstyle=true -Dair.check.skip-license=true; mv target/presto-rakam-*/* ../presto/plugin/presto-rakam-raptor'
  EOH
end

#include_recipe 'presto::service'

#service 'presto' do
#  action :start
#end
