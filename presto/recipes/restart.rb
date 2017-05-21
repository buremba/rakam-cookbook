bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto-streamer && (bin/launcher restart) && (killall -9 presto-collector-heartbeat || true) && (../presto-collector-heartbeat &)'
  EOH
end