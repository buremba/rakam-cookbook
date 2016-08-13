bash "wait until coordinator becomes visible" do
  code <<-EOH
    for i in $(seq 600 $END); do if sudo opsworks-agent-cli get_json | jq '.opsworks.layers.presto.instances.presto1' | grep -q "id"; then break; else sleep 1; fi done;
  EOH
end