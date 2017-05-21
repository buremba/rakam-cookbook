bash "run prestodb" do
  code <<-EOH
    su webapp -l -c 'if [ -d '/home/webapp/presto' ]; then (/home/webapp/presto/bin/launcher stop) && (killall -9 presto-server-heartbeat || true); fi'
  EOH
end

bash "run prestodb" do
  code <<-EOH
    su webapp -l -c 'if [ -d '/home/webapp/presto-streamer/bin' ]; then (/home/webapp/presto-streamer/bin/launcher stop) && (killall -9 presto-streamer-heartbeat || true); fi'
  EOH
end