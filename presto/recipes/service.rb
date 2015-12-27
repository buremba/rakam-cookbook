service "presto" do
  supports :status => true, :stop => true, :start => true
  start_command "cd /home/webapp/presto && bin/launcher start"
  stop_command "cd /home/webapp/presto && bin/launcher stop"
  status_command "cd /home/webapp/presto && bin/launcher status"
  action :nothing
end
