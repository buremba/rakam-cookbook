service 'clickhouse-server' do
  action :restart
end

bash "run worker" do
  code <<-EOH
    for i in $(seq 600 $END); do if curl --output /dev/null --silent --head --fail http://127.0.0.1:8123; then break; else sleep 1; fi done;
    curl --output /dev/null --silent --head --fail http://127.0.0.1:8123 && su metrika -l -c 'cd /home/metrika/worker; bin/launcher restart'
  EOH
end