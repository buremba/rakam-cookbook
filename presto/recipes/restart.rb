bash "run presto" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto && (bin/launcher restart) && (killall -9 presto-server-heartbeat || true) && (../presto-server-heartbeat &)'
  EOH
end

bash "run collector" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto-collector && (bin/launcher restart) && (killall -9 presto-collector-heartbeat || true) && (../presto-collector-heartbeat &)'
  EOH
end