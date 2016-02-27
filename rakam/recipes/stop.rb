bash "stop program" do
  code <<-EOH
    su webapp -l -c 'test -d "/home/webapp/rakam-server" && (cd /home/webapp/rakam-server; bin/launcher stop)'
  EOH
end
