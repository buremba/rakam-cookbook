zookeeper '3.4.8'

template "/opt/zookeeper/zookeeper.cfg" do
  source "zookeeper.cfg.erb"
  owner "zookeeper"
  group "zookeeper"
  mode 0755
end

zookeeper_config '/opt/zookeeper/zookeeper.cfg'
zookeeper_service 'zookeeper'