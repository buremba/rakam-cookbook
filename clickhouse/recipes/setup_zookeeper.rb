template "/opt/zookeeper/zookeeper.cfg" do
  source "zookeeper.cfg.erb"
  owner "zookeeper"
  group "zookeeper"
  mode 0755
end