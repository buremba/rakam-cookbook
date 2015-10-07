service "rakam_ui" do
  supports :status => true, :stop => true
  start_command "cd /home/webapp && nohup java -Dhttp.server.address=0.0.0.0:5000 -Dlog.levels-file=log.properties -Dlog.output-file=logs/app.log -Dlog.enable-console=false -cp rakam/rakam/target/dependency/*: org.rakam.ServiceStarter config.properties &"
  stop_command "(! [ -e $(pgrep java) ] && pkill -f 'java' || echo "No java process running on the machine. No action taken" fail)"
  status_command "pgrep java"
  action :nothing
end
