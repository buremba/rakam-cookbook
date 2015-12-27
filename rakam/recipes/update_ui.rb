bash "download and build ui" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'if cd rakam-ui; then git pull; else git clone https://github.com/buremba/rakam-ui.git && cd rakam-ui; fi'
    su webapp -l -c 'cd rakam-ui; npm install' 
  EOH
end