bash "run collector" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto-streamer && (bin/launcher start) && (killall -9 presto-collector-heartbeat || true) && (../presto-collector-heartbeat &)'
  EOH
end