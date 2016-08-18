service "presto" do
  supports :status => true, :stop => true, :start => true, :restart => true
  init_command "echo 'init'"
  start_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher start'"
  stop_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher stop'"
  restart_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher restart'"
  status_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher status'"
  action :nothing
end
