bash "run prestodb" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto && (bin/launcher start) && (killall -9 presto-server-heartbeat || true) && (../presto-server-heartbeat &)'
  EOH
end