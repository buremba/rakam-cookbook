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

directory node['data-dir'] do
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

template "/home/webapp/presto/etc/event-listener.properties" do
  source "event-listener.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

template "/home/webapp/presto/etc/logging.properties" do
  source "logging.properties.erb"
  owner "webapp"
  group "webapp"
  variables ({ :version => `bash -c "if [ -z ${PRESTO_RAKAM_STREAMING_VERSION+x} ]; then curl -s https://api.bintray.com/packages/buremba/maven/presto-rakam-streaming | jq -r '.latest_version'; else echo $PRESTO_RAKAM_STREAMING_VERSION; fi"` })
  mode 0644
end

template "/home/webapp/presto-server-heartbeat" do
  source "presto-server-heartbeat.sh"
  owner "webapp"
  group "webapp"
  mode 0775
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

template "/home/webapp/presto/etc/catalog/external.properties" do
  source "catalog/external.properties.erb"
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

presto_download_address = "https://repo1.maven.org/maven2/com/facebook/presto/presto-server/#{node['presto_version']}/presto-server-#{node['presto_version']}.tar.gz"
presto_main_patch_download_address = "https://dl.bintray.com/buremba/maven/com/facebook/presto/presto-main/#{node['presto_version']}/presto-main-#{node['presto_version']}.jar"

bash "download-and-setup-presto" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'wget -N #{presto_download_address}'
    su webapp -l -c 'tar -zxvf presto-server-#{node['presto_version']}.tar.gz'
    su webapp -l -c 'rm -rf presto/bin && cp -r presto-server-#{node['presto_version']}/bin/ presto/'
    su webapp -l -c 'rm -rf presto/lib && cp -r presto-server-#{node['presto_version']}/lib/ presto/'
    su webapp -l -c 'wget -q #{presto_main_patch_download_address} -O presto/lib/presto-main-#{node['presto_version']}.jar'
    su webapp -l -c 'STREAMING_VERSION="$(if [ -z #{node['rakam_presto_streaming_version']} ]; then curl -s https://api.bintray.com/packages/buremba/maven/presto-rakam-streaming | jq -r '.latest_version'; else echo #{node['rakam_presto_streaming_version']}; fi)" && wget -nc "https://dl.bintray.com/buremba/maven/com/facebook/presto/presto-rakam-streaming/${STREAMING_VERSION}/presto-rakam-streaming-${STREAMING_VERSION}.zip" && unzip -o "presto-rakam-streaming-${STREAMING_VERSION}.zip" && rm -rf ./presto/plugin/presto-rakam-streaming && mkdir ./presto/plugin/presto-rakam-streaming && mv presto-rakam-streaming-${STREAMING_VERSION}/* ./presto/plugin/presto-rakam-streaming; test ${PIPESTATUS[0]} -eq 0'
    su webapp -l -c 'RAPTOR_VERSION="$(if [ -z #{node['rakam_presto_raptor_version']} ]; then curl -s https://api.bintray.com/packages/buremba/maven/presto-rakam-raptor | jq -r '.latest_version'; else echo #{node['rakam_presto_raptor_version']}; fi)" && wget -nc "https://dl.bintray.com/buremba/maven/com/facebook/presto/presto-rakam-raptor/${RAPTOR_VERSION}/presto-rakam-raptor-${RAPTOR_VERSION}.zip" && unzip -o "presto-rakam-raptor-${RAPTOR_VERSION}.zip" && rm -rf ./presto/plugin/presto-rakam-raptor && mkdir ./presto/plugin/presto-rakam-raptor && mv presto-rakam-raptor-${RAPTOR_VERSION}/* ./presto/plugin/presto-rakam-raptor; test ${PIPESTATUS[0]} -eq 0'
  EOH
end
