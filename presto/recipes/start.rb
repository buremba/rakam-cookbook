bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/presto && (bin/launcher start) && (./presto-server-heartbeat &)'
  EOH
end