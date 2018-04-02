bash "run prestodb" do
  code <<-EOH
    su webapp -l -c 'if [ -d '/home/webapp/presto-streamer/bin' ]; then (/home/webapp/presto-streamer/bin/launcher stop) && (killall -9 presto-streamer-heartbeat || true); fi'
  EOH
end