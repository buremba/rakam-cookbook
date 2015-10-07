service "rakam_ui" do
  supports :status => true, :stop => true
  start_command "cd /var/www && nohup java -Dhttp.server.address=0.0.0.0:5000 -Dlog.levels-file=/var/www/log.properties -Dlog.output-file=/var/wwwlogs/app.log -Dlog.enable-console=false -cp /var/www/rakam/rakam/target/dependency/*: org.rakam.ServiceStarter /var/www/config.properties &"
  stop_command "(! [ -e $(pgrep java) ] && pkill -f 'java' || echo "No java process running on the machine. No action taken" fail)"
  status_command "pgrep java"
  action [ :enable, :start ]
end
