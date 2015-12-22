bash "download and build package" do
  user "webapp"
  cwd "home/webapp"
  environment ({ 'HOME' => ::Dir.home("webapp"), 'USER' => "webapp" })
  code <<-EOH
    if cd rakam-ui; then git pull; else git clone https://github.com/buremba/rakam-ui.git && cd rakam-ui; fi
    npm install
  EOH
end
