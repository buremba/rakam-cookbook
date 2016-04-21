bash "download and build ui" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'if cd rakam-ui; then ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_ui; git pull"; else ssh-agent bash -c "ssh-add /home/webapp/.ssh/rakam_ui; git clone git@github.com:buremba/rakam-ui.git" && cd rakam-ui; fi'
    su webapp -l -c 'cd rakam-ui; npm install' 
  EOH
end
