service 'clickhouse-server' do
  action :stop
end

bash "run worker" do
  code <<-EOH
    su metrika -l -c 'cd /home/metrika/worker; bin/launcher stop'
  EOH
end