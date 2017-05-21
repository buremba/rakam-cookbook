service "presto" do
  supports :status => true, :stop => true, :start => true, :restart => true
  init_command "/home/webapp/presto"
  start_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher start'"
  stop_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher stop'"
  restart_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher restart'"
  status_command "su webapp -l -c 'cd /home/webapp/presto && bin/launcher status'"
  action :nothing
end

service "presto-streamer" do
  supports :status => true, :stop => true, :start => true, :restart => true
  init_command "/home/webapp/presto-streamer"
  start_command "su webapp -l -c 'cd /home/webapp/presto-streamer && bin/launcher start'"
  stop_command "su webapp -l -c 'cd /home/webapp/presto-streamer && bin/launcher stop'"
  restart_command "su webapp -l -c 'cd /home/webapp/presto-streamer && bin/launcher restart'"
  status_command "su webapp -l -c 'cd /home/webapp/presto-streamer && bin/launcher status'"
  action :nothing
end
