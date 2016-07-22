service 'clickhouse-server' do
  action :stop
end

bash "run worker" do
  code <<-EOH
    curl --output /dev/null --silent --head --fail http://127.0.0.1:8123 && su metrika -l -c 'cd /home/metrika/worker; bin/launcher stop'
  EOH
end