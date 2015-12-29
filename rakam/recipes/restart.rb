include_recipe 'rakam::update_ui'

bash "run program" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/rakam-server; bin/launcher restart'
  EOH
end
