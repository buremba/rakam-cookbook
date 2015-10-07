bash "stop program" do
  user "webapp"
  environment ({ 'HOME' => ::Dir.home("webapp"), 'USER' => "webapp" })
  code <<-EOH
    isExistApp=`pgrep java`
    if [[ -n  $isExistApp ]]; then
       pkill -f 'java'
    else 
    	echo "No java process running on the machine. No action taken"
    fi
  EOH
end
