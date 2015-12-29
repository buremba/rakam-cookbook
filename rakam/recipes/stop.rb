bash "stop program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/rakam-server; bin/launcher stop'
  EOH
end