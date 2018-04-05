bash "stop program" do
  code <<-EOH
    su webapp -l -c 'if [ -d '/home/webapp/rakam-server' ]; then (/home/webapp/rakam-server/bin/launcher stop) && (killall -9 rakam-server-heartbeat || true); fi'
  EOH
end
