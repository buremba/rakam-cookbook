bash "stop program" do
  user "webapp"
  environment ({ 'HOME' => ::Dir.home("webapp"), 'USER' => "webapp" })
  code <<-EOH
    (! [ -e $(pgrep java) ] && pkill -f 'java' || echo 'No java process running on the machine. No action taken' fail)
  EOH
end
