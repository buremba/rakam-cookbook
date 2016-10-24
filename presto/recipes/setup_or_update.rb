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

template "/home/webapp/presto/etc/logging.properties" do
  source "logging.properties.erb"
  owner "webapp"
  group "webapp"
  variables ({ :version => `bash -c "curl -s https://api.bintray.com/packages/buremba/maven/presto-rakam-streaming | jq -r '.latest_version'"` })
  mode 0644
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

presto_download_address = "https://repo1.maven.org/maven2/com/facebook/presto/presto-server/#{node['presto_version']}/presto-server-#{node['presto_version']}.tar.gz"

bash "download-and-setup-presto" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'wget -N #{presto_download_address}'
    su webapp -l -c 'tar -zxvf presto-server-#{node['presto_version']}.tar.gz'
    su webapp -l -c 'rm -rf presto/bin && cp -r presto-server-#{node['presto_version']}/bin/ presto/'
    su webapp -l -c 'rm -rf presto/lib && cp -r presto-server-#{node['presto_version']}/lib/ presto/'
    su webapp -l -c 'STREAMING_VERSION="$(curl -s https://api.bintray.com/packages/buremba/maven/presto-rakam-streaming | jq -r '.latest_version')" && wget -nc "https://dl.bintray.com/buremba/maven/com/facebook/presto/presto-rakam-streaming/${STREAMING_VERSION}/presto-rakam-streaming-${STREAMING_VERSION}.zip" && unzip -o "presto-rakam-streaming-${STREAMING_VERSION}.zip" && rm -rf ./presto/plugin/presto-rakam-streaming && mkdir ./presto/plugin/presto-rakam-streaming && mv presto-rakam-streaming-${STREAMING_VERSION}/* ./presto/plugin/presto-rakam-streaming; test ${PIPESTATUS[0]} -eq 0'
    su webapp -l -c 'if cd presto-rakam-raptor; git checkout #{node['rakam_raptor_checkout']}; then git pull; else git clone https://github.com/buremba/presto-rakam-raptor.git && cd presto-rakam-raptor; fi'
    su webapp -l -c 'cd presto-rakam-raptor; mvn clean install -DskipTests -Dair.check.skip-checkstyle=true -Dair.check.skip-license=true; rm -r ../presto/plugin/presto-rakam-raptor; mv target/presto-rakam-*/ ../presto/plugin/presto-rakam-raptor'
  EOH
end
