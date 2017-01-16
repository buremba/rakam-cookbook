bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto && (bin/launcher restart) && (killall -9 presto-server-heartbeat) && (./presto-server-heartbeat &)'
  EOH
end