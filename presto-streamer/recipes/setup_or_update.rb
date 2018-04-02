
bash "clean-setup" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'rm -rf ./presto-streamer'
  EOH
end

directory "/home/webapp/presto-streamer" do
  owner "webapp"
  group "webapp"
  mode 0755
end
directory "/home/webapp/presto-streamer/etc" do
  owner "webapp"
  group "webapp"
  mode 0755
end
template "/home/webapp/presto-streamer/etc/jvm.config" do
  source "collector/jvm.config.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end
template "/home/webapp/presto-streamer/etc/config.properties" do
  source "collector/config.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end
template "/home/webapp/presto-streamer/etc/log.properties" do
  source "collector/log.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end
template "/home/webapp/presto-collector-heartbeat" do
  source "collector/presto-collector-heartbeat.sh"
  owner "webapp"
  group "webapp"
  mode 0775
end

presto_streamer_download_address = "https://s3.amazonaws.com/rakam-private-code/rakam-presto-builds/#{node['presto_version']}/latest.tar.gz"

bash "download-and-setup-presto-collector" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'wget -N #{presto_streamer_download_address}'
    su webapp -l -c 'tar -zxvf latest.tar.gz'
    su webapp -l -c 'mv collector-*/* ./presto-streamer/'
    su webapp -l -c 'rm -r collector-* && rm latest.tar.gz'
  EOH
end
