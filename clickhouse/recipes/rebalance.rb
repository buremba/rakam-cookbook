bash "rebalance_master" do
  code <<-EOH
     curl -X POST -d @<(sudo opsworks-agent-cli get_json | jq '.opsworks.layers.rakam.instances | map(select(.status | contains("online")))') http://localhost:5466/move_parts
  EOH
end

template "/etc/clickhouse-server/config.xml" do
  source "config.xml.erb"
  owner "metrika"
  group "metrika"
  mode 0755
end