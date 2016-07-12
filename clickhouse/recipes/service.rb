service "clickhouse" do
  supports :status => true, :stop => true, :start => true
  start_command "sudo service clickhouse-server start"
  stop_command "sudo service clickhouse-server stop"
  status_command "sudo service clickhouse-server status"
  action :nothing
end
